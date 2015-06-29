package org.misoton.misotter;

import java.util.HashMap;

public interface ConvertHash {
    HashMap<String, String> convertToHash();
    void convertFromHash(HashMap<String, String> map);
}
