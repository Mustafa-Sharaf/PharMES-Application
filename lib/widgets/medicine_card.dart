import 'package:flutter/material.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';

class MedicineCard extends StatelessWidget {
  final Map<String, dynamic> stock;
  final Map<String, dynamic> medicine;
  final String highlightField;
  final String icon;

  const MedicineCard({
    super.key,
    required this.stock,
    required this.medicine,
    this.highlightField = '',
    this.icon = ''
  });
  @override
  Widget build(BuildContext context) {
    final quantityColor = highlightField == 'quantity' ? Colors.red : DefaultTextStyle.of(context).style.color;
    final expiresColor = highlightField == 'expires' ? Colors.red : DefaultTextStyle.of(context).style.color;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3,
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                medicine['trade_name'] ?? '',
                style:  TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.045,),
              ),
              if ((medicine['composition'] ?? '').toString().isNotEmpty)
                Padding(
                  padding:  EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.01),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text('Composition: ', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04,)),
                      Expanded(
                        child: Text(
                          medicine['composition'],
                          style:  TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04,),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                ),
              if ((medicine['titer'] ?? '').toString().isNotEmpty)
                Padding(
                  padding:  EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.01,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Text(
                          'Titer: ${medicine['titer']}',
                          style:  TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04,),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Text(
                          'Quantity: ${stock['quantity'] ?? ''}',
                          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04, color:quantityColor),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
            ],),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Purchase Price: ${stock['Purchase_price'] ?? ''}',style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),),
                Text('Sale Price: ${stock['sale_price'] ?? ''}',style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04,),),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Expires: ${stock['expiration_date'] ?? ''}',
                      style: TextStyle(color: expiresColor, fontSize: MediaQuery.of(context).size.width * 0.04,),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize:  Size(MediaQuery.of(context).size.width*0.077, MediaQuery.of(context).size.height*0.035),
                      padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.017, vertical: MediaQuery.of(context).size.height*0.0018),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: icon == 'missing' ? AppColors.primaryColor: Colors.red[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      icon == 'missing' ? "💊➕" : "💊➖",
                      style:  TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037,),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
