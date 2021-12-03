<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Vale extends CI_Controller
{

    public function __construct()
    {
        parent::__construct();
    }


    public function index()
    {
        echo "demee";

    }
    public function arachazirla($masaid=null)
    {
     $data['masaid']=$masaid;
     $this->load->view('aracgetir',$data);
 }
 public function crud()
 { 

    $action = $this->input->post("action"); 

    if ($action=='LOGIN'){

        $user = $this->input->post("user");
        $pass  = $this->input->post("pass");
        

        $result = $this->db->select("*")->from("kullanicilar")->where("username='".md5($user)."' and Password='".md5($pass)."' and yetki='Vale'")->get()->result();

        if (!empty($result)) {
         echo json_encode($result);
     } else {
        echo "error";
    }
}

if($action=='UPDATE_EMP')
{
  $id=$this->input->post("id");
  $this->db->where("id",$id)->update('vale',['status'=>1]);
  echo "success";  
}

if ($action=='GET_ALL'){

    $result=$this->db->query("SELECT id,plaka,zaman from vale where status=0");
    if(!empty($result)){
     $dbdata = array();
     foreach ($result->result_array() as $row)
     {
        $dbdata[]=$row;
    }
    echo json_encode($dbdata);
}else{
    echo "error";
}




}
}

public function register()
{
    $data =['plaka'=>strtoupper($this->input->post("plaka")),
    'masa_id'=> $this->input->post("masano"),
    'zaman'=>$this->input->post("zaman")
    ];     
    if($this->db->insert('vale',$data)){
         echo "oldu";
    }
   

}
}