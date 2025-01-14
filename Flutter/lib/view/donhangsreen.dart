import 'package:flutter/material.dart';

class DonHangScreen extends StatefulWidget {
  @override
  _DonHangScreenState createState() => _DonHangScreenState();
}

class _DonHangScreenState extends State<DonHangScreen> {
  String _selectedStatus = 'Tất cả';
  
  // Sample order data
  final List<Map<String, dynamic>> orders = [
    {
      'id': 'DH001',
      'date': '2025-01-10',
      'status': 'Chờ xác nhận',
      'total': 1250000,
      'items': [
        {
          'name': 'Sản phẩm A',
          'quantity': 2,
          'price': 500000,
        },
        {
          'name': 'Sản phẩm B',
          'quantity': 1,
          'price': 250000,
        },
      ],
    },
    {
      'id': 'DH002',
      'date': '2025-01-09',
      'status': 'Đang giao',
      'total': 800000,
      'items': [
        {
          'name': 'Sản phẩm C',
          'quantity': 1,
          'price': 800000,
        },
      ],
    },
  ];

  List<String> orderStatuses = [
    'Tất cả',
    'Chờ xác nhận',
    'Đang giao',
    'Đã giao',
    'Đã hủy'
  ];

  List<Map<String, dynamic>> getFilteredOrders() {
    if (_selectedStatus == 'Tất cả') {
      return orders;
    }
    return orders.where((order) => order['status'] == _selectedStatus).toList();
  }

  void _showOrderDetail(Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (_, controller) => Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Chi tiết đơn hàng ${order['id']}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Divider(),
              Text(
                'Ngày đặt: ${order['date']}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Trạng thái: ${order['status']}',
                style: TextStyle(
                  fontSize: 16,
                  color: order['status'] == 'Chờ xác nhận' ? Colors.orange : Colors.blue,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Sản phẩm:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: controller,
                  itemCount: order['items'].length,
                  itemBuilder: (context, index) {
                    final item = order['items'][index];
                    return ListTile(
                      title: Text(item['name']),
                      subtitle: Text('Số lượng: ${item['quantity']}'),
                      trailing: Text(
                        '${item['price']} đ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tổng tiền:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${order['total']} đ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              if (order['status'] == 'Chờ xác nhận')
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        // Implement order cancellation logic here
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Đơn hàng đã được hủy'),
                          ),
                        );
                      },
                      child: Text(
                        'Hủy đơn hàng',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredOrders = getFilteredOrders();
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Đơn hàng của tôi'),
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: orderStatuses.length,
              itemBuilder: (context, index) {
                final status = orderStatuses[index];
                final isSelected = status == _selectedStatus;
                
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: FilterChip(
                    selected: isSelected,
                    label: Text(status),
                    onSelected: (selected) {
                      setState(() {
                        _selectedStatus = status;
                      });
                    },
                    backgroundColor: isSelected ? Colors.blue : Colors.grey[200],
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: filteredOrders.isEmpty
                ? Center(
                    child: Text('Không có đơn hàng nào'),
                  )
                : ListView.builder(
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = filteredOrders[index];
                      return Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: InkWell(
                          onTap: () => _showOrderDetail(order),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Đơn hàng ${order['id']}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      order['status'],
                                      style: TextStyle(
                                        color: order['status'] == 'Chờ xác nhận'
                                            ? Colors.orange
                                            : Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Text('Ngày đặt: ${order['date']}'),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${order['items'].length} sản phẩm',
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    Text(
                                      '${order['total']} đ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}