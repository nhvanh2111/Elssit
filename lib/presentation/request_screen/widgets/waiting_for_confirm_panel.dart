import 'package:elssit/core/models/booking_models/booking.dart';
import 'package:elssit/presentation/request_screen/widgets/request_detail_screen.dart';
import 'package:elssit/presentation/request_screen/widgets/request_item.dart';
import 'package:flutter/Material.dart';

class WaitingForConfirmPanel extends StatefulWidget {
  const WaitingForConfirmPanel({Key? key, required  this.lisWaitingBooking}) : super(key: key);
  final List<Booking> lisWaitingBooking;
  @override
  State<WaitingForConfirmPanel> createState() => _WaitingForConfirmPanelState();
}

class _WaitingForConfirmPanelState extends State<WaitingForConfirmPanel> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: null,
      builder: (context, snapshot) {
        return Material(
          child: Container(
            width: size.width,
            color: Colors.white,
            child: ListView.separated(
              padding: const EdgeInsets.all(0),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  RequestDetailScreen(idBooking: widget.lisWaitingBooking[index].id),));
                },
                child: requestItem(context,widget.lisWaitingBooking[index]),
              ),
              separatorBuilder: (context, index) => Container(
                width: size.width,
                height: 1,
                margin: EdgeInsets.only(
                    top: size.height * 0.01, bottom: size.height * 0.02),
                color: Colors.black.withOpacity(0.1),
              ),
              itemCount: widget.lisWaitingBooking.length,
            ),
          ),
        );
      },
    );
  }
  
}
