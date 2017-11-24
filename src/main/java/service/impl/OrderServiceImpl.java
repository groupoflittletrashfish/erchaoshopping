package service.impl;

import dao.OrderDao;
import entity.Item;
import entity.Order;
import entity.Trade;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.transaction.Transaction;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import service.OrderService;
import utils.PageHelper;

import javax.annotation.Resource;
import java.sql.Array;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("orderServiceImpl")
public class OrderServiceImpl implements OrderService {

    @Resource(name = "orderDao")
    private OrderDao orderDao;
    @Resource(name = "txManager")
    private DataSourceTransactionManager manager;

    public JSONArray orderList(String query) {
        Map<String, Object> map = new HashMap<String, Object>();
        if (!"".equals(query)) {
            JSONObject param = new JSONObject().fromObject(query);
            map = (Map) param;
        }
        System.out.println("map:"+map);

        JSONArray array = new JSONArray();
        List<Trade> trades = orderDao.orderList(map);
        for (Trade t : trades) {
            List<Order> orderList = orderDao.getOrderByTradeId(t.getId());
            JSONObject obj = new JSONObject();
            obj.put("status", t.getStatus());
            obj.put("buyerNick", t.getBuyerNick());
            obj.put("tid", t.getTid());
            obj.put("created", t.getCreated());
            obj.put("payment", t.getPayment());
            obj.put("orders", new JSONArray().fromObject(orderList));
            array.add(obj);
        }

        return array;
    }

    public List<Item> allItems() {
        return orderDao.allItems();
    }

    public boolean insertData(Trade trade, String data) {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);// 事物隔离级别，开启新事务
        TransactionStatus status = manager.getTransaction(def); // 获得事务状态
        try {
            trade.setTabobaoId((long) 123456789);
            trade.setCreated(new Timestamp(System.currentTimeMillis()));
            orderDao.insertTrade(trade);
            System.out.println("id:"+trade.getId());
            JSONArray array = new JSONArray().fromObject(data);
            int count = 0;
            for (int x = 0; x < array.size(); x++) {
                JSONObject obj = array.getJSONObject(x);
                Long itemId = obj.getLong("itemId");
                Item item = orderDao.getItemById(itemId);
                String title = item.getTitle();
                Float price = item.getPrice();

                Order order = new Order();
                order.setTid(trade.getId());
                order.setTaobaoId(Long.valueOf(123456789));
                order.setNumIid(item.getId());
                order.setNum(obj.getInt("num"));
                order.setPrice(item.getPrice());
                order.setTitle(item.getTitle());
                order.setStatus(trade.getStatus());
                order.setCreated(new Timestamp(System.currentTimeMillis()));
                int re = orderDao.insertOrder(order);
                if (re > 0) {
                    count++;
                }
            }
            manager.commit(status);       //数据提交
            if (count == array.size()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            manager.rollback(status);   //捕获异常回滚
        }
        return false;
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public boolean batchDelete(String ids) {
        boolean result=false;
        try{
            String[] i=ids.split("-");
            Long[] idArr=new Long[i.length];
            for(int x=0;x<i.length;x++){
                idArr[x]=Long.valueOf(i[x]);
            }
            Long[] tids=new Long[orderDao.batchSelectTradeId(idArr).size()];
            orderDao.batchSelectTradeId(idArr).toArray(tids);
            System.out.println("tids"+tids);
            orderDao.batchDelete(idArr);
            orderDao.batchDeleteOrders(tids);
            result=true;
        }catch(Exception e){
            e.printStackTrace();
            result=false;
            throw new RuntimeException("删除异常");    //抛出异常为了让spring捕获
        }finally {
            return result;
        }
    }

    public Trade selectTradeById(Long tid){
        return orderDao.selectTradeById(tid);
    }

    public List<Order> tradeOrders(Long id){
        List<Order> orderList=orderDao.getOrderByTradeId(id);
        return orderList;
    }

    public boolean updateTrade(Trade trade) {
        int i=orderDao.updateTrade(trade);
        if(i>0){
            return true;
        }
        return false;
    }

    public boolean updateOrder(Long tid,String param) {
        Trade trade=orderDao.selectTradeById(tid);
        int count=0;
        int i=orderDao.deleteOrderByTid(trade.getId());
        if(i==0) {
            return false;
        }
        JSONArray array=new JSONArray().fromObject(param);
        for(int x=0;x<array.size();x++){
            Order order=new Order();
            JSONObject obj=array.getJSONObject(x);
            Long id=obj.getLong("id");
            int num=obj.getInt("num");
            Item item=orderDao.getItemById(id);
            order.setTid(trade.getId());
            order.setTaobaoId(Long.valueOf(123456789));
            order.setNumIid(id);
            order.setNum(num);
            order.setPrice(item.getPrice());
            order.setTitle(item.getTitle());
            order.setStatus(trade.getStatus());
            order.setCreated(new Timestamp(System.currentTimeMillis()));
            orderDao.insertOrder(order);
            count++;
        }

        if(count==array.size()){
            return true;
        }
        return false;
    }

    public boolean submitUpdate(String param){
        return false;
    }
}
