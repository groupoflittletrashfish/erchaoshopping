package service;

import net.sf.json.JSONObject;

import java.util.Map;

public interface OrderService {
    public JSONObject orderList(int limit,int offset,String query,String type);
}
