package org.misoton.misotter

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.util.Log
import android.widget.Button
import android.widget.EditText
import android.widget.Toast
import retrofit.RestAdapter
import retrofit.RetrofitError
import java.util.*

class SignUpActivity() : AppCompatActivity() {

    val user_name_exit: EditText by bindView(R.id.sign_up_user_id)
    val password_exit: EditText by bindView(R.id.sign_up_password)
    val register_button: Button by bindView(R.id.sign_up_register_button)


    override fun onCreate(savedInstanceState: Bundle?) {
        super<AppCompatActivity>.onCreate(savedInstanceState)
        setContentView(R.layout.activity_sign_up)

        getSupportActionBar().hide()

        register_button.setOnClickListener {
            submitUser(user_name_exit.getText().toString(), password_exit.getText().toString())
        }
    }

    fun submitUser(user_id: String, password: String) {
        // connection to server
        getRetroService().signUp(user_id, password, RequestCallback(SignUpListener(this)))
    }

    public class SignUpListener(val activity: Activity) : RequestListener<User> {
        override fun onSuccess(response: User?) {
            response?.let {
                response!!
                activity.dLog("Success!!!!!!!!!" + response.getUserId().toString())
                if(!response.getUserId().equals("")){
                    UserInfo.login_user = response
                    activity.showToast(UserInfo.login_user.getUserId().toString())
                    activity.transitionActivity("TimelineActivity", true)
                } else {
                    activity.showToast("ユーザー作成に失敗しました。")
                }

            }
        }

        override fun onFailure(error: RetrofitError?) {
            error?.getResponse()?.getStatus()
            dLog("Failure?????????")
        }

        fun asa(res_user: User?) {

        }

    }
}
