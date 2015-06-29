package org.misoton.misotter

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ArrayAdapter
import android.widget.TextView

class TimelineListAdapter(context: Context, val resource: Int, val tweets: MutableList<org.misoton.misotter.Tweet>?): ArrayAdapter<org.misoton.misotter.Tweet>(context, resource, tweets) {

    val layout_inflater = context.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater

    override fun getView(position: Int, convertView: View?, parent: ViewGroup): View? {
        val item: org.misoton.misotter.Tweet = getItem(getCount() - 1 - position)

        var convert_view: View = convertView ?: layout_inflater.inflate(R.layout.tweet_item_layout, null)

        val first_of_id = item.getUserId().charAt(0)
        val thumbnail_char = if (!first_of_id.isSurrogate()) first_of_id.toString() else first_of_id.toString() + item.getUserId().charAt(1)
        (convert_view.findViewById(R.id.tweet_item_id_thumbnail_text_view) as TextView).setText(thumbnail_char)
        (convert_view.findViewById(R.id.tweet_item_body_text_view) as TextView).setText(item.getBody())
        (convert_view.findViewById(R.id.tweet_item_id_text_view) as TextView).setText("@" + item.getUserId())

        return convert_view
    }
}