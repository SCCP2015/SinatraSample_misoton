package org.misoton.misotter

import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.view.View
import android.widget.Button

class MainActivity() : AppCompatActivity(){

    val sign_in_button: Button by bindView(R.id.main_sign_in_button)
    val sign_up_button: Button by bindView(R.id.main_sign_up_button)

    override fun onCreate(savedInstanceState: Bundle?){
        super<AppCompatActivity>.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        getSupportActionBar().hide()

        sign_in_button.setOnClickListener { transitionActivity("SignInActivity", true) }
        sign_up_button.setOnClickListener { transitionActivity("SignUpActivity", true) }
    }
}
