import processing.net.*;


Server s;

Client c;

void serverSetup() {
    s = new Server(this, 2000);
    c = new Client(this, "127.0.0.1", 2000);
    
    c.write("Connected");
    delay(10);
    Client recieved = s.available();
    println("Server Recieved: " + recieved.readString());
}

void serverCheck(){
    Client recieved = s.available();
    if(recieved == null) return;
    String input = recieved.readString();
    //parse input
    boolean download = true;
    String ip = "0";
    String file = "30,30,3,0/2,16,16/2,30,30/2,30,28/2,30,27/1,29,27";
    if (download){
        s.write("<download>" + file + "<ip>" + ip + "<end>");
    }
    
}

void uploadMap(){
    c.write("<start>" + "0,0,0" + "<end>");
}

void downloadMap(){
    int mapId = 1;
    c.write("<download>" + mapId + "<ip>" + c.ip() + "<end>");
}
