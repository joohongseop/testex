<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="../includes/header.jsp"%>


<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Read</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class='bigPictureWrapper'>
	<div class='bigPicture'></div>
</div>

<style>
	.uploadResult {
		width:100%;
  		background-color: gray;
	}
	.uploadResult ul{
  		display:flex;
  		flex-flow: row;
  		justify-content: center;
  		align-items: center;
	}
	.uploadResult ul li {
  		list-style: none;
  		padding: 10px;
  		align-content: center;
  		text-align: center;
	}
	.uploadResult ul li img{
  		width: 100px;
	}
	.uploadResult ul li span {
  		color:white;
	}
	.bigPictureWrapper {
  		position: absolute;
  		display: none;
  		justify-content: center;
  		align-items: center;
  		top:0%;
  		width:100%;
  		height:100%;
  		background-color: gray; 
  		z-index: 100;
  		background:rgba(255,255,255,0.5);
	}
	.bigPicture {
  		position: relative;
  		display:flex;
  		justify-content: center;
  		align-items: center;
	}
	.bigPicture img {
  		width:600px;
	}
</style>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">

			<div class="panel-heading">Board Read Page</div>
			<!-- /.panel-heading -->
			<div class="panel-body">

				<div class="form-group">
					<label>Bno</label>
					<input class="form-control" name='bno' value='<c:out value="${board.bno}"/>' readonly="readonly">
				</div>

				<div class="form-group">
					<label>Title</label>
					<input class="form-control" name='title' value='<c:out value="${board.title}"/>' readonly="readonly">
				</div>

				<div class="form-group">
					<label>Text area</label>
					<textarea class="form-control" rows="3" name='content' readonly="readonly"><c:out value="${board.content}"/></textarea>
				</div>
							
				<div class="form-group">
					<label>Writer</label>
					<input class="form-control" name='writer' value='<c:out value="${board.writer}"/>' readonly="readonly">
				</div>

				<!-- <button data-oper='modify' class="btn btn-default">Modify</button> -->
				<sec:authentication property="principal" var="pinfo"/>
				<sec:authorize access="isAuthenticated()">
					<c:if test="${pinfo.username eq board.writer}">
						<button data-oper='modify' class="btn btn-default">Modify</button>
					</c:if>
				</sec:authorize>
				
				<button data-oper='list' class="btn btn-info">List</button>

				<form id='operForm' action="/board/modify" method="get">
					<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
					<input type='hidden' name='pageNum'	value='<c:out value="${cri.pageNum}"/>'>
					<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
					<input type='hidden' name='keyword'	value='<c:out value="${cri.keyword}"/>'>
					<input type='hidden' name='type' value='<c:out value="${cri.type}"/>'>
				</form>
				
			</div>
			<!--  end panel-body -->

		</div>
		<!--  end panel-body -->
	</div>
	<!-- end panel -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Files</div>
      		<!-- /.panel-heading -->
      		<div class="panel-body">
        		<div class='uploadResult'> 
          			<ul></ul>
        		</div>
      		</div>
      		<!--  end panel-body -->
    	</div>
    	<!--  end panel-body -->
  	</div>
  	<!-- end panel -->
</div>
<!-- /.row -->

<!-- 댓글의 추가 버튼 -->
<div class='row'>
	<div class="col-lg-12">
    	<!-- /.panel -->
    	<div class="panel panel-default">
		<!--    <div class="panel-heading">
        			<i class="fa fa-comments fa-fw"></i> Reply
      			</div> -->
      		<div class="panel-heading">
        		<i class="fa fa-comments fa-fw"></i> Reply
        		<sec:authorize access="isAuthenticated()">
        			<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New Reply</button>
        		</sec:authorize>
      		</div>      
      		<!-- /.panel-heading -->
      		<div class="panel-body">
      			<sec:authentication property="principal" var="pinfo"/>
      			<sec:authorize access="isAuthenticated()">
  					<textarea id='reply2' style="margin: 0px;width: 90%;height: 100px;resize: none;"></textarea>
      				<input type='hidden' id='replyer2' value="${pinfo.username}">
      				<input type="button" id="RegisterBtn" value="등록">
      			</sec:authorize>
        		<ul class="chat"></ul>
        	<!-- ./ end ul -->
      		</div>
      		<!-- /.panel .chat-panel -->
			<div class="panel-footer"></div>
		</div>
	</div>
<!-- ./ end row -->
</div>

<!-- Modal -->
<!-- 댓글의 추가를 Modal을 이용해서 추가 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
        	<div class="modal-header">
            	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
              	<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
            </div>
            <div class="modal-body">
            	<div class="form-group">
                	<label>Reply</label> 
                	<input class="form-control" name='reply' value='New Reply!!!!'>
              	</div>
            	<div class="form-group">
                	<label>Replyer</label> 
                	<input class="form-control" name='replyer' value='replyer'>
              	</div>
              	<div class="form-group">
                	<label>Reply Date</label> 
                	<input class="form-control" name='replyDate' value='2018-01-01 13:13'>
              	</div>
            </div>
			<div class="modal-footer">
        		<button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
        		<button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
        		<button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
        		<button id='modalCloseBtn' type="button" class="btn btn-default">Close</button>
      		</div>
      	</div>
    	<!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->


<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/reply.js"></script>

<script>
$(document).ready(function () {
	var bnoValue = '<c:out value="${board.bno}"/>';
	var replyUL = $(".chat");
    showList(1);
    function showList(page){
    	console.log("show list " + page);
    	// 해당 게시물의 댓글을 가져오기 위함
    	replyService.getList({bno:bnoValue,page: page|| 1 }, function(replyCnt, list) {
    		console.log("replyCnt: "+ replyCnt );
    		console.log("list: " + list);
    		console.log(list);
    		
    		// page 번호가 -1이면 마지막 페이지를 찾아서 다시 호출함
    		if(page == -1) {
    			pageNum = Math.ceil(replyCnt/10.0);
    			showList(pageNum);
    			return;
    		}
      
    		var str="";
    		
    		if(list == null || list.length == 0) {
    			return;
    		}
    		
    		// 댓글의 시간을 표시해주는 함수
    		for (var i = 0, len = list.length || 0; i < len; i++) {
    			str +="<li class='left clearfix' data-rno='" + list[i].rno + "'>";
    			str +="  <div><div class='header'><strong class='primary-font'>[" +list[i].rno+ "] " + list[i].replyer + "</strong>"; 
       			str +="    <small class='pull-right text-muted'>" + replyService.displayTime(list[i].updateDate) + "</small></div>";
       			str +="    <p>" +list[i].reply + "</p></div></li>";
     		}
    		
		    replyUL.html(str);
		    showReplyPage(replyCnt);
		});//end function
	}//end showList
    
    var pageNum = 1;
    var replyPageFooter = $(".panel-footer");
    
    // 댓글의 페이징 처리
    function showReplyPage(replyCnt) {
    	var endNum = Math.ceil(pageNum / 10.0) * 10;  
    	var startNum = endNum - 9; 
    	
    	var prev = startNum != 1;
    	var next = false;
    	if(endNum * 10 >= replyCnt) {
    		endNum = Math.ceil(replyCnt/10.0);
    	}
      
      	if(endNum * 10 < replyCnt) {
      		next = true;
      	}
      
      	var str = "<ul class='pagination pull-right'>";
      
      	if(prev) {
      		str += "<li class='page-item'><a class='page-link' href='" + (startNum -1) + "'>Previous</a></li>";
      	}
      
      	for(var i = startNum ; i <= endNum; i++) {
        	var active = pageNum == i ? "active" : "";
        	str += "<li class='page-item " + active + " '><a class='page-link' href='" + i + "'>" + i + "</a></li>";
        }
      
		if(next) {
			str += "<li class='page-item'><a class='page-link' href='" + (endNum + 1) + "'>Next</a></li>";
		}
      
      	str += "</ul></div>";
      
      	console.log(str);
      	replyPageFooter.html(str);
    }
     
    replyPageFooter.on("click","li a", function(e){
    	e.preventDefault();
    	console.log("page click");
       
    	var targetPageNum = $(this).attr("href");
    	console.log("targetPageNum: " + targetPageNum);
    	pageNum = targetPageNum;
    	showList(pageNum);
    });     
   
    var modal = $(".modal");
    var modalInputReply = modal.find("input[name='reply']");
    var modalInputReplyer = modal.find("input[name='replyer']");
    var modalInputReplyDate = modal.find("input[name='replyDate']");
    
    var modalModBtn = $("#modalModBtn");
    var modalRemoveBtn = $("#modalRemoveBtn");
    var modalRegisterBtn = $("#modalRegisterBtn");
    
	var replyer = null;
    
    <sec:authorize access="isAuthenticated()">
    	//현재 로그인한 사용자
    	replyer = '<sec:authentication property="principal.username"/>';   
	</sec:authorize>
	
	var csrfHeaderName ="${_csrf.headerName}"; 
    var csrfTokenValue="${_csrf.token}";
    
    $("#modalCloseBtn").on("click", function(e) {
    	modal.modal('hide');
    });
    
    // 입력에 필요한 부분만을 표시하고 그 외의 부분은 모두  숨김처리
    /* $("#addReplyBtn").on("click", function(e) {
    	modal.find("input").val("");
    	modal.find("input[name='replyer']").val(replyer);
    	modalInputReplyDate.closest("div").hide();
    	modal.find("button[id !='modalCloseBtn']").hide();
    	
    	modalRegisterBtn.show();
    	$(".modal").modal("show");
    }); */
    
    //Ajax spring security header
    $(document).ajaxSend(function(e, xhr, options) { 
        xhr.setRequestHeader(csrfHeaderName, csrfTokenValue); 
    }); 
    
	// 새로운 댓글을 추가하는 부분
    $("#RegisterBtn").on("click",function(e) {
    	var reply = { reply: $('#reply2').val(), replyer:$('#replyer2').val(), bno:bnoValue };
    	replyService.add(reply, function(result){
    		alert(result);
    		modal.find("input").val("");
    		modal.modal("hide");
    		//showList(1);
    		$('#reply2').val("");
    		showList(-1);
    	});
    });
    
	// 새로운 댓글을 추가하는 부분
	/*modalRegisterBtn.on("click",function(e) {
    	var reply = { reply: modalInputReply.val(), replyer:modalInputReplyer.val(), bno:bnoValue };
    	replyService.add(reply, function(result){
    		alert(result);
    		modal.find("input").val("");
    		modal.modal("hide");
    		//showList(1);
    		showList(-1);
    	});
    }); */

  	//댓글 조회 클릭 이벤트 처리 
    $(".chat").on("click", "li", function(e) {
    	var rno = $(this).data("rno");
    	replyService.get(rno, function(reply) {
    		modalInputReply.val(reply.reply);
    		modalInputReplyer.val(reply.replyer).attr("readonly","readonly");
    		modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly","readonly");
    		modal.data("rno", reply.rno);
    		modal.find("button[id !='modalCloseBtn']").hide();
    		var originalReplyer = modalInputReplyer.val();
    		if(replyer == originalReplyer) {
    			modalModBtn.show();
    			modalRemoveBtn.show();
    		}
    		$(".modal").modal("show");
    	});
    });
  
	// 댓글의 수정처리
    modalModBtn.on("click", function(e) {
    	var reply = {rno:modal.data("rno"), reply: modalInputReply.val()};
    	if(!replyer) {
    		alert("로그인후 수정이 가능합니다.");
   		  	modal.modal("hide");
   		  	return;
   	  	}
    	
    	//원래 댓글의 작성자
   	  	var originalReplyer = modalInputReplyer.val();
   	 	console.log("Original Replyer: " + originalReplyer);
   	 	
   	 	// 로그인한 사용자가 댓글의 작성자가 아닐 경우
   	  	if(replyer  != originalReplyer) {
   		  	alert("자신이 작성한 댓글만 수정이 가능합니다.");
   		  	modal.modal("hide");
   		  	return;
   		}
   	  	
   	  	replyService.update(reply, function(result) {
   	  		alert(result);
     	    modal.modal("hide");
     	    showList(pageNum);
     	});
    });
   	
	// 댓글의 삭제 처리
    modalRemoveBtn.on("click", function (e) {
    	var rno = modal.data("rno");
    	console.log("RNO: " + rno);
    	console.log("REPLYER: " + replyer);
    	
    	if(!replyer) {
    		alert("로그인후 삭제가 가능합니다.");
    		modal.modal("hide");
    		return;
    	}
    	
    	var originalReplyer = modalInputReplyer.val();
    	console.log("Original Replyer: " + originalReplyer);
    	
    	if(replyer  != originalReplyer) {
    		alert("자신이 작성한 댓글만 삭제가 가능합니다.");
    		modal.modal("hide");
    		return;
    	}
    	
    	replyService.remove(rno, originalReplyer, function(result) {
    		alert(result);
    		modal.modal("hide");
    		showList(pageNum);
    	});
    });
});
</script>

<script type="text/javascript">
	$(document).ready(function() {
		var operForm = $("#operForm");
		$("button[data-oper='modify']").on("click",	function(e) {
			operForm.attr("action", "${pageContext.request.contextPath}/board/modify").submit();
		});
		$("button[data-oper='list']").on("click", function(e) {
			operForm.find("#bno").remove();
			operForm.attr("action", "${pageContext.request.contextPath}/board/list")
			operForm.submit();
		});
	});
</script>

<script>
	$(document).ready(function() {
		//호스트주소에 시작부터 끝까지 인덱스번호를 가져옴.
		var hostIndex = location.href.indexOf( location.host ) + location.host.length;
		//'/{contextPath}'를 가져온다
		var contextPath = location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1));
		
		(function(){
    		var bno = '<c:out value="${board.bno}"/>';    		
			$.getJSON(contextPath + "/board/getAttachList", {bno: bno}, function(arr) {
       			console.log(arr);
       			var str = "";
       			$(arr).each(function(i, attach) {
         			//image type
         			if(attach.fileType)	{
           				var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
           
           				str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
           				str += "<img src='"+contextPath+"/display?fileName="+fileCallPath+"'>";
           				str += "</div>";
           				str +"</li>";
         			} else {
           				str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
           				str += "<span> "+ attach.fileName+"</span><br/>";
           				str += "<img src='"+contextPath+"/resources/img/attach.png'></a>";
           				str += "</div>";
           				str +"</li>";
         			}
       			});
      		 	$(".uploadResult ul").html(str);       
     		});//end getjson

    
  		})();//end function
  
  		$(".uploadResult").on("click","li", function(e) {
			console.log("view image");
    		var liObj = $(this);
    		var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));
    
    		if(liObj.data("type")) {
      			showImage(path.replace(new RegExp(/\\/g),"/"));
    		} else {
      			//download 
      			self.location = contextPath+"/download?fileName="+path
    		}
  		});
  
  		function showImage(fileCallPath) {
    		alert(fileCallPath);
    		$(".bigPictureWrapper").css("display","flex").show();
    		$(".bigPicture").html("<img src='"+contextPath+"/display?fileName="+fileCallPath+"' >").animate({width:'100%', height: '100%'}, 1000);
  		}

  		$(".bigPictureWrapper").on("click", function(e) {
		    $(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
		    setTimeout(function() {
		      $('.bigPictureWrapper').hide();
		    }, 1000);
  		});
	});
</script>

<%@include file="../includes/footer.jsp"%>
