$(document).ready(
	function registration() {
		$('#register').on('submit', function(event) {
			$.ajax({
				data : {
					name : $('#registerUser').val(),
					passw : $('#registerPass').val()
				},
				type : 'POST',
				url : '/register'
			})
			.done(function(data) {
				if (data.error) {
					$('#errorReg').text(data.error).show();
				}
				else {
					$('#errorReg').hide();
					$('#registerPanel').css("display", "none");
					alert("Registered successfully");
					configLogoutBtns();
					sessionStorage.setItem("user", name);
				}
			});
			event.preventDefault();
		});
	}
);

$(document).ready(
	function login() {
		$('#login').on('submit', function(event) {
			$.ajax({
				data : {
					name : $('#loginName').val(),
					passw : $('#loginPass').val()
				},
				type : 'POST',
				url : '/login'
			})
			.done(function(data) {
				if (data.error) {
					$('#errorLogin').text(data.error).show();
				}
				else {
					$('#errorLogin').hide();
					$('#loginPanel').css("display", "none");
					alert("Logged in successfully");
					configLogoutBtns();
					name = data.success;
					sessionStorage.setItem("user", name);
				}
			});
			event.preventDefault();
		});
	}
);

$(document).ready(
	function addTopic() {
		$('#newTopic').on('submit', function(event) {
			$.ajax({
				data : {
					tName : $('#topicName').val(),
				},
				type : 'POST',
				url : '/addTopic'
			})
			.done(function(data) {
				if (data.error) {
					$('#errorTopic').text(data.error).show();
				}
				else {
					$('#newTopicPanel').css("display", "none");
					alert("Topic added");
					$('#topics').load(location.href + ' #topics');
				}
			});
			event.preventDefault();
		});
	}
);

$(document).ready(
	function addClaim() {
		$('#newClaim').on('submit', function(event) {
			var rel = [];
			var OpEq = [];
			$("input:checkbox[id=related]:checked").each(function(){
				rel.push($(this).next('label').text());
				OpEq.push($(this).next().next('select').val());
			});			
			$.ajax({
				data : {
					cHeader : $('#claimHeader').val(),
					tName : $('h1.topicName').text(),
					related : JSON.stringify(rel),
					oppEqu : JSON.stringify(OpEq),
				},
				type : 'POST',
				url : '/addClaim'
			})
			.done(function(data) {
				if (data.error) {
					$('#errorClaim').text(data.error).show();
				}
				else {
					$('#newClaimPanel').css("display", "none");
					$('#claims').load(location.href + ' #claims');
					alert("Claim added");
				}
			});
			event.preventDefault();
		});
	}
);

$(document).ready(
	function addReplyToClaim() {
		$('#newReplyToClaim').on('submit', function(event) {
			relation = $("#claimRelation").val();
			$.ajax({
				data : {
					reply : $('#replyCText').val(),
					cHeader : $('h1.claimHeader').text(),
					pReply : "",
					relation : relation,
				},
				type : 'POST',
				url : '/addReply'
			})
			.done(function(data) {
				if (data.error) {
					$('#errorReply').text(data.error).show();
				}
				else {
					$('#newReplyPanelC').css("display", "none");
					$('#replys').load(location.href + ' #replys');
					alert("Reply added");
				}
			});
			event.preventDefault();
		});
	}
);

$(document).ready(
	function addReplyToReply() {
		$('#newReplyToReply').on('submit', function(event) {
			pReply = $("#pReplyID").text();
			relation = $("#replyRelation").val();
			$.ajax({
				data : {
					reply : $('#replyRText').val(),
					cHeader : $('h1.claimHeader').text(),
					pReply : pReply,
					relation : relation,
				},
				type : 'POST',
				url : '/addReply'
			})
			.done(function(data) {
				if (data.error) {
					$('#errorReply').text(data.error).show();
				}
				else {
					$('#newReplyPanelR').css("display", "none");
					$('#replys').load(location.href + ' #replys');
					alert("Reply added");
				}
			});
			event.preventDefault();
		});
	}
);

function checkLogged() {
	var username = document.getElementById("check").innerHTML = sessionStorage.getItem("user");
	if (username == null || username == "null") {
		configLoginBtns();
	} else {
		configLogoutBtns();
	}
}

function configLoginBtns() {
	$('.loginBtns').css("display", "block");
	$('.logoutBtns').css("display", "none");
	$('.newTopicBtn').css("display", "none");
	$('.newClaimBtn').css("display", "none");
	$('.newReplyBtn').css("display", "none");
}

function configLogoutBtns() {
	$('.logoutBtns').css("display", "block");
	$('.loginBtns').css("display", "none");
	$('.newTopicBtn').css("display", "block");
	$('.newClaimBtn').css("display", "block");
	$('.newReplyBtn').css("display", "block");
}

function logout() {
	$.ajax({
		type : "POST",
		url : '/logout',
		dataType: "json",
		contentType: 'application/json;charset=UTF-8',
	});
	configLoginBtns();
	alert("Logged out successfully");
	sessionStorage.setItem("user", null);
}

function login() {
	$('#loginPanel').css("display", "block");
}

function register() {
	$('#registerPanel').css("display", "block");
}

function addTopic() {
	$('#newTopicPanel').css("display", "block");
}

function addClaim() {
	$('#newClaimPanel').css("display", "block");
}

function addReplyC() {
	$('#newReplyPanelC').css("display", "block");
}

function addReplyR() {
	$('#newReplyPanelR').css("display", "block");
}

window.onclick = function(event) {
  if (event.target == document.getElementById("loginPanel")) {
    $('#loginPanel').css("display", "none");
  } else if (event.target == document.getElementById("registerPanel")) {
    $('#registerPanel').css("display", "none");
  } else if (event.target == document.getElementById("newTopicPanel")) {
    $('#newTopicPanel').css("display", "none");
  } else if (event.target == document.getElementById("newClaimPanel")) {
    $('#newClaimPanel').css("display", "none");
  } else if (event.target == document.getElementById("newReplyPanelC")) {
    $('#newReplyPanelC').css("display", "none");
  } else if (event.target == document.getElementById("newReplyPanelR")) {
    $('#newReplyPanelR').css("display", "none");
  }
} 