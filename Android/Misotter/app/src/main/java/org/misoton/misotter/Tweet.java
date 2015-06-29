package org.misoton.misotter;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class Tweet {

    @SerializedName("tweet_id")
    @Expose
    private String tweetId;
    @SerializedName("user_id")
    @Expose
    private String userId;
    @Expose
    private String body;
    @Expose
    private String time;

    /**
     *
     * @return
     * The tweetId
     */
    public String getTweetId() {
        return tweetId;
    }

    /**
     *
     * @param tweetId
     * The tweet_id
     */
    public void setTweetId(String tweetId) {
        this.tweetId = tweetId;
    }

    /**
     *
     * @return
     * The userId
     */
    public String getUserId() {
        return userId;
    }

    /**
     *
     * @param userId
     * The user_id
     */
    public void setUserId(String userId) {
        this.userId = userId;
    }

    /**
     *
     * @return
     * The body
     */
    public String getBody() {
        return body;
    }

    /**
     *
     * @param body
     * The body
     */
    public void setBody(String body) {
        this.body = body;
    }

    /**
     *
     * @return
     * The time
     */
    public String getTime() {
        return time;
    }

    /**
     *
     * @param time
     * The time
     */
    public void setTime(String time) {
        this.time = time;
    }

}