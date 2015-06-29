package org.misoton.misotter;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Callable;

import retrofit.Callback;
import retrofit.http.GET;
import retrofit.http.POST;
import retrofit.http.Query;

public interface RetroFitApi {
    @POST("/signup")
    void signUp(@Query("user_id") String user_id, @Query("password") String password, Callback<User> cb);

    @GET("/timeline")
    void timeline(@Query("user_id") String user_id, @Query("password") String password, @Query("tweet_num") int tweet_num, Callback<List<Tweet>> cb);

    @POST("/signin")
    void signIn(@Query("user_id") String user_id, @Query("password") String password, Callback<User> cb);

    @POST("/tweet")
    void tweet(@Query("user_id") String user_id, @Query("password") String password, @Query("body") String body, @Query("time") String time, Callback<User> cb);
}
