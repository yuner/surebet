library yservice;

import 'vm.dart';

part 'service_translator.dart';

// register a service
// unregister a service
// service heart beat (with or without status)
// set a status
// unset a status

// require a service
// respone a service
// respone continue
// cancel request

// require collaboration
// accept collaboration
// deny collaboration
// collaboration heart beat

// announce a redirection
// take a redirection
// redirect a service
// reject redirect

// require update collaboration status
// accept update collaboration status
// deny update collaboration status
// update collaboration status
// parallel status updated

/*
service type:
  pipe
  hub
  by_status   

communication type:
  socket
  http
  broadcast_stream
  

  

*/

class serviceServer extends VMbase
{

}
