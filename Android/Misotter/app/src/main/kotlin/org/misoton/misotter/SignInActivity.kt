package org.misoton.misotter

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.widget.Button
import android.widget.EditText
import retrofit.RestAdapter
import retrofit.RetrofitError

class SignInActivity() : AppCompatActivity() {

    val user_name_exit: EditText by bindView(R.id.sign_in_user_id)
    val password_exit: EditText by bindView(R.id.sign_in_password)
    val sign_in_button: Button by bindView(R.id.sign_in_button)

    override fun onCreate(savedInstanceState: Bundle?) {
        super<AppCompatActivity>.onCreate(savedInstanceState)
        setContentView(R.layout.activity_sign_in)

        getSupportActionBar().hide()

        if (UserInfo.login_user.getUserId() != "") {
            val intent = Intent(this, javaClass<TimelineActivity>()).setAction(Intent.ACTION_VIEW)
            startActivity(intent)
            finish()
        }
        sign_in_button.setOnClickListener { loginUser(user_name_exit.getText().toString(), password_exit.getText().toString()) }
    }

    fun loginUser(user_id: String, password: String) {
        // connection to server

        val restAdapter: RestAdapter = RestAdapter.Builder().setEndpoint("http://27.133.130.191:9292").build()
        val service = restAdapter.create(javaClass<RetroFitApi>())

        service.signIn(user_id, password, RequestCallback(SignInListener(this, user_id)))
    }

    class SignInListener(val activity: Activity, val user_id: String) : RequestListener<User> {
        override fun onSuccess(response: User?) {
            response?.let {
                response!!
                activity.dLog("Success!!!!!!!!!" + response.getUserId().toString())
                if(!response.getUserId().equals("")) {
                    UserInfo.login_user = response
                    activity.transitionActivity("TimelineActivity", true)
                } else {
                    activity.showToast("ログインに失敗しました。")
                }

            }
        }

        override fun onFailure(error: RetrofitError?) {
            dLog("Failure?????????")
        }

    }
}
