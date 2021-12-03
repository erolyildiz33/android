<!DOCTYPE html>
<html lang="en">
<head>
	<title>Araç Hazırlama</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!--===============================================================================================-->
	<link rel="icon" type="image/png" href="<?=base_url()?>assets/vale/images/icons/favicon.ico"/>
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="<?=base_url()?>assets/vale/vendor/bootstrap/css/bootstrap.min.css">
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="<?=base_url()?>assets/vale/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="<?=base_url()?>assets/vale/vendor/animate/animate.css">
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="<?=base_url()?>assets/vale/vendor/css-hamburgers/hamburgers.min.css">
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="<?=base_url()?>assets/vale/vendor/select2/select2.min.css">
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="<?=base_url()?>assets/vale/css/util.css">
	<link rel="stylesheet" type="text/css" href="<?=base_url()?>assets/vale/css/main.css">
	<link rel="stylesheet" type="text/css" href="<?=base_url()?>assets/vale/css/jquery.datetimepicker.min.css">
	<!--===============================================================================================-->
</head>
<body>

	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100">
				<div class="login100-pic js-tilt" data-tilt>
					<img src="<?=base_url()?>assets/vale/images/img-01.png" alt="IMG">
				</div>

				<form  action="<?=base_url()?>vale/register" method="post" class="login100-form validate-form">
					<span class="login100-form-title">
						Araç Hazırla
					</span>
					<input type="hidden"  name="<?=$this->security->get_csrf_token_name();?>" value="<?=$this->security->get_csrf_hash();?>" />
					<div class="wrap-input100 validate-input" data-validate = "Örnek : 33AA333">
						<input class="input100" type="text" name="plaka" id="plaka" placeholder="Plakanız">
						<input type="hidden" value="<?=$masaid?>" name="masano" id="masano">
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<i class="fa fa-car" aria-hidden="true"></i>
						</span>
					</div>

					<div class="wrap-input100 validate-input" data-validate = "Zaman">
						<input class="input100" type="text"  step="3000" name="zaman" id="zaman" placeholder="Zaman">
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<i class="fa fa-clock-o" aria-hidden="true"></i>
						</span>
					</div>

					<div class="container-login100-form-btn">
						<button type="button" id="sendData" class="login100-form-btn">
							Aracımı Hazırla
						</button>
					</div>


				</form>
			</div>
		</div>
	</div>




	<!--===============================================================================================-->
	<script src="<?=base_url()?>assets/vale/vendor/jquery/jquery-3.2.1.min.js"></script>
	<script src="<?=base_url()?>assets/vale/js/jquery.datetimepicker.full.js"></script>
	<script src="<?=base_url()?>assets/vale/js/socket.io.min.js"></script>
	<!--===============================================================================================-->
	<script src="<?=base_url()?>assets/vale/vendor/bootstrap/js/popper.js"></script>
	<script src="<?=base_url()?>assets/vale/vendor/bootstrap/js/bootstrap.min.js"></script>
	<!--===============================================================================================-->
	<script src="<?=base_url()?>assets/vale/vendor/select2/select2.min.js"></script>
	<!--===============================================================================================-->
	<script src="<?=base_url()?>assets/vale/vendor/tilt/tilt.jquery.min.js"></script>


	<script>
		$(document).on('click','#sendData',function(){
			var socket = io("https://www.mersinroof14.com/");
			var plaka = $("#plaka").val();
			var zaman = $("#zaman").val();
			var masano = $("#masano").val();
			
			
			$.ajax({
				url: '<?=base_url()?>vale/register',
				type: 'POST',
				dataType: 'json',
				data: { plaka: plaka, zaman: zaman,masano:masano },
				success: function (gelenveri) {
					if(gelenveri=='oldu'){
						socket.emit('add_car','ekle');
					}
					
				},
				error: function (hata) {					
				}
			});
		});


		$('.js-tilt').tilt({
			scale: 1.1
		})
		$('#zaman').datetimepicker({
			datepicker:false,
			format:"H:i",
			step:15,
		});
	</script>
	<!--===============================================================================================-->
	<script src="<?=base_url()?>assets/vale/js/main.js"></script>


</body>
</html>