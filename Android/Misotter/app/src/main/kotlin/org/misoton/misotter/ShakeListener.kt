package org.misoton.misotter

import android.app.Activity
import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import java.util.*
import kotlin.properties.Delegates

class ShakeListener(val activity: Activity, val on_shake: ()->Unit) : SensorEventListener {
    val sensorManager = activity.getSystemService(Context.SENSOR_SERVICE) as SensorManager

    val sensor = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)

    var gravity = FloatArray(3)

    var linear_acceleration = FloatArray(3)

    val alpha: Float = 0.8f

    var shaking = false

    val SHAKE_LENGTH = 10f

    var print_length_timer: Timer? = Timer()

    var shake_count_timer: Timer? = Timer()

    init {
        sensorManager.registerListener(this, sensor, SensorManager.SENSOR_DELAY_NORMAL)
    }

    fun start(){
        print_length_timer = Timer()
        shake_count_timer = Timer()
        print_length_timer?.schedule(PrintLengthTask(this), 0L, 1000L)
        shake_count_timer?.schedule(ShakeCountTask(this, 4), 0L, 20L)
    }

    fun stop(){
        print_length_timer?.cancel()
        shake_count_timer?.cancel()

        print_length_timer = null
        shake_count_timer = null
    }

    class PrintLengthTask(val shake_listener: ShakeListener): TimerTask(){
        override fun run() {
            dLog("================shake")
            for(value in shake_listener.linear_acceleration){
                dLog("==" + value + "==")
            }
            dLog("")
        }
    }

    class ShakeCountTask(val shake_listener: ShakeListener, val threshold: Int): TimerTask(){
        var counter = 0

        override fun run() {
            if(shake_listener.shaking){
                counter++
            } else {
                counter = 0
            }
            if(counter >= threshold){
                shake_listener.on_shake()
            }
        }
    }

    override fun onSensorChanged(event: SensorEvent) {
        gravity[0] = alpha * gravity[0] + (1 - alpha) * event.values[0];
        gravity[1] = alpha * gravity[1] + (1 - alpha) * event.values[1];
        gravity[2] = alpha * gravity[2] + (1 - alpha) * event.values[2];

        // Remove the gravity contribution with the high-pass filter.
        linear_acceleration[0] = event.values[0] - gravity[0];
        linear_acceleration[1] = event.values[1] - gravity[1];
        linear_acceleration[2] = event.values[2] - gravity[2];

        shaking = linear_acceleration.sum() > SHAKE_LENGTH
    }

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {
    }

}