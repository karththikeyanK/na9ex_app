import 'package:flutter/widgets.dart';
import 'package:na9ex_app/constants.dart';
import 'package:na9ex_app/service/api_client.dart';

class TicketService{

  Future<void> onClickUpdateStatus (BuildContext context,int id, int status) async {
    print("TicketService::onClickedUpdateStatus::started. ");
    var response =  await ApiClient().updateStatus(context, id,status);
    if(response){
      if(status == 1){
        print("Ticket is Confirmed");
        showCustomAlert(context, "SUCCESS","Ticket is Booked","success");
      }else if(status==2){
        print("TicketService::onClickedUpdateStatus()::Ticket Cancelled!");
        showCustomAlert(context, "WARNING", "Ticket Moved to Pending","warning");
      }
      else if(status == 3){
        print("TicketService::onClickedUpdateStatus:: Ticket Pending");
        showCustomAlert(context, "SUCCESS", "Ticket Moved to Pending","success");
      }else if(status == 4){
        print("TicketService::onClickedUpdateStatus()::Ticket Deleted");
        showCustomAlert(context, "SUCCESS", "Ticket Deleted","success");
      }
    }
  }


  Future<void> onClickedDelete(BuildContext context, int id) async {
    print("TicketService::onClickedDelete()::started.");
    bool response = await ApiClient().deleteTicket(context, id);
    if(response){
      print("TicketService()::onClickedDelete():: Ticket Deleted");
      showCustomAlert(context, SUCCESS, "Ticket Deleted Successfully", "success");
    }else{
      print("ERROR OCCURRED");
    }
  }
}