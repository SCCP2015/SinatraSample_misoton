package org.misoton.misotter

import android.app.Activity
import android.hardware.SensorEventListener
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.view.View
import android.widget.*
import com.fasterxml.jackson.databind.ObjectMapper
import retrofit.RestAdapter
import retrofit.RetrofitError
import java.util.*
import kotlin.properties.Delegates

class TimelineActivity : AppCompatActivity() {
    val time_line_list: ListView by bindView(R.id.timeline_list)
    val now_loading_text: TextView by bindView(R.id.timeline_now_loading)
    val tweet_edit_text: EditText by bindView(R.id.timeline_tweet_et)
    val tweet_button: ImageView by bindView(R.id.timeline_tweet_bt)
    var listener: ShakeListener by Delegates.notNull()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_timeline)

        listener = ShakeListener(this, { loadTimeline() })
        listener.stop()

        getSupportActionBar().hide()
        loadTimeline()
        tweet_button.setOnClickListener {
            getRetroService().tweet(UserInfo.login_user.getUserId(), UserInfo.login_user.getPassword(), tweet_edit_text.getText().toString(), "999", RequestCallback(TweetListener(this)))
            tweet_edit_text.setText("")
        }
    }

    override fun onPause(){
        super.onPause()

        listener.stop()
    }

    override fun onResume(){
        super.onResume()

        listener.start()
    }

    fun loadTimeline(){
        getRetroService().timeline(UserInfo.login_user.getUserId(), UserInfo.login_user.getPassword(), 10, RequestCallback(TimelineListener(this)))

    }

    fun updateTimeline(tweets: List<Tweet>) {
        val adapter = TimelineListAdapter(this, 0, tweets as MutableList)
        time_line_list.setAdapter(adapter)
    }

    class TimelineListener(val activity: TimelineActivity) : RequestListener<List<Tweet>> {
        override fun onSuccess(response: List<Tweet>?) {
            response?.let {
                response!!
                activity.dLog("Success!!!!!!!!!")
                activity.updateTimeline(response)
                activity.now_loading_text.setVisibility(View.GONE)
            }
        }

        override fun onFailure(error: RetrofitError?) {
            error?.getResponse()?.getStatus()
            dLog("Failure?????????")
        }

    }

    class TweetListener(val activity: TimelineActivity) : RequestListener<User> {
        override fun onSuccess(response: User?) {
            response?.let {
                response!!
                activity.dLog("Success!!!!!!!!!")
                activity.loadTimeline()
            }
        }

        override fun onFailure(error: RetrofitError?) {
            error?.getResponse()?.getStatus()
            dLog("Failure?????????")
        }

    }

}
