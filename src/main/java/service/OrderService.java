package service;

import entity.Item;
import entity.Order;
import entity.Trade;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.util.List;
import java.util.Map;

public interface OrderService {
    public JSONArray orderList(String query);

    public List<Item> allItems();

    public boolean insertData(Trade trade,String data);

    public boolean batchDelete(String ids);

    public Trade selectTradeById(Long tid);

    public List<Order> tradeOrders(Long id);

    public boolean updateTrade(Trade trade);

    public boolean updateOrder(Long tid,String param);
}
