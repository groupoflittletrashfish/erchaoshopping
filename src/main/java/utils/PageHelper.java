package utils;

import java.util.Map;

public class PageHelper {
    public static void pageSet(int limit,int offset,Map<String,Object> map){
        map.put("limit",offset);
        map.put("offset",limit+offset);
    }
}
