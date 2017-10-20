package service.impl;

import dao.OrderDao;
import entity.Order;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Service;
import service.OrderService;
import utils.PageHelper;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class OrderServiceImpl implements OrderService{

    @Resource(name="orderDao")
    private OrderDao orderDao;

    public JSONObject orderList(int limit,int offset,String query,String type){
        Map<String,Object> map=new HashMap<String, Object>();
        map.put("query",query);
        map.put("type",type);
        PageHelper.pageSet(limit,offset,map);
        int total=orderDao.allOrders();
        System.out.println("map:"+map);
        List<Order> orderList=orderDao.orderList(map);
        JSONObject obj=new JSONObject();
        obj.put("total",total);
        obj.put("rows",new JSONArray().fromObject(orderList));
        return obj;
    }
}
