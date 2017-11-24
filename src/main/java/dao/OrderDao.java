package dao;

import entity.Item;
import entity.Order;
import entity.Trade;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface OrderDao {

    public List<Trade> orderList(Map map);

    public int allOrders();

    public int isExist(String num);

    public void updateOrder(Order order);

    public List<Order> getOrderByTradeId(long tid);

    public List<Item> allItems();

    public Long insertTrade(Trade trade);

    public int insertOrder(Order order);

    public Item getItemById(Long id);

    public void batchDelete(Long[] arr);

    public List<Long> batchSelectTradeId(Long[] arr);

    public void batchDeleteOrders(Long[] arr);

    public Trade selectTradeById(Long tid);

    public int updateTrade(Trade trade);

    public int deleteOrderByTid(Long tid);
}
