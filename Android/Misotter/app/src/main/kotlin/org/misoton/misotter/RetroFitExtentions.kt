package org.misoton.misotter

import android.app.Activity
import retrofit.RestAdapter

fun Activity.getRetroService(): RetroFitApi {
    val restAdapter: RestAdapter = RestAdapter.Builder().setEndpoint("http://27.133.130.191:9292").build()
    return restAdapter.create(javaClass<RetroFitApi>())
}