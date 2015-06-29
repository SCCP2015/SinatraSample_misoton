package org.misoton.misotter;

import java.util.HashMap;

public interface MisotterResponseListener {
    void onResponse(String url, HashMap<String, String> map);
}
