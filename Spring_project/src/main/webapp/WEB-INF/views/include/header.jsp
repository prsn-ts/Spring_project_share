<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link href="https://fonts.googleapis.com/css2?family=Gugi&family=Nanum+Brush+Script&family=Ranchers&display=swap" rel="stylesheet">

	<!-- index header -->
	<div class="jumbotron py-5 text-center mb-0" style="font-family: 'Nanum Brush Script', cursive;"> 
		<a class="main_title" href="${pageContext.request.contextPath}/home.do">오늘의 레시피</a>
		<a class="sub_title" href="${pageContext.request.contextPath}/home.do">오늘의 레시피는 과연?</a>
	</div>
	
	<!-- Topbar -->
    <nav class="navbar navbar-expand navbar-light topbar static-top shadow">
    	<div class="container">
	        <div class="collapse navbar-collapse" id="collapsibleNavbar"> 
	       	 	<ul class="navbar-nav"> 
	        		<li class="nav-item"><a href="${pageContext.request.contextPath}/home.do" class="navbar-brand nav-link font-weight-bolder text-dark">요리</a></li> 
	       		 	<li class="nav-item"><a href="${pageContext.request.contextPath}/my_recipe/myrecipe.do" class="navbar-brand nav-link font-weight-bolder text-dark">나만의 조리법</a></li>
	       		 	<li class="nav-item"><a href="${pageContext.request.contextPath}/magazine/magazine.do" class="navbar-brand nav-link font-weight-bolder text-dark">매거진</a></li>
	       		 	<li class="nav-item"><a href="${pageContext.request.contextPath}/bbs_board/list.do" class="navbar-brand nav-link font-weight-bolder text-dark">게시판</a></li>
	     	    </ul> 
	        </div>
	        <c:if test="${empty id }">
	        	<ul class="navbar-nav ml-auto">
	            	<li class="nav-item dropdown no-arrow">     
	                  <span class="mr-2 d-none d-lg-inline text-gray-600 small">
		                  <a class="login_btn btn btn-outline-success" href="${pageContext.request.contextPath}/login/login_form.do">로그인</a>
		                  <a class="signup_btn btn btn-outline-success" href="${pageContext.request.contextPath}/login/signup_form.do">회원가입</a>
	                  </span>            
	                </li>
	            </ul>
	        </c:if>
	        <!-- Topbar Navbar -->
	        <c:if test="${not empty id}">
	        <ul class="navbar-nav ml-auto">
	            	
	            	<!-- Nav Item - User Information -->
	            	<li class="nav-item dropdown no-arrow">
	                <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                  <span class="mr-2 d-none d-lg-inline text-gray-600 small">${id }</span>
	                  <c:choose>
						<c:when test="${empty dto.profile and empty dto.saveFileName}">
							<img class="nav-profile" id="profileImage" src="${pageContext.request.contextPath}/resources/images/noprofile.jpg">
						</c:when>
						<c:otherwise>
							<img class="nav-profile" id="profileImage" src="${pageContext.request.contextPath}/resources${dto.profile}">
						</c:otherwise>
	                  </c:choose>            
	                </a>
	            
	                <!-- Dropdown - User Information -->
	                
	                <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
		                  <a class="dropdown-item" href="${pageContext.request.contextPath}/login/private/info.do">
		                  	${id } &nbsp; Profile
		                  </a>
	                  <div class="dropdown-divider"></div>
		                  <a class="dropdown-item" href="${pageContext.request.contextPath}/login/logout.do">
		                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
		                    Logout
		                  </a>
	               	</div>
	            </li>
	        </ul>
           	</c:if>
	    </div> 
    </nav>
    <!-- End of Topbar -->