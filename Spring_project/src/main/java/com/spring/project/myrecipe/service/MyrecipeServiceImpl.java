package com.spring.project.myrecipe.service;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.spring.project.login.dao.LoginDao;
import com.spring.project.login.dto.LoginDto;
import com.spring.project.myrecipe.dao.MyrecipeDao;
import com.spring.project.myrecipe.dto.MyrecipeDto;
import com.spring.project.tempmyrecipe.dao.TempMyrecipeDao;
import com.spring.project.tempmyrecipe.dto.TempMyrecipeDto;

@Service
public class MyrecipeServiceImpl implements MyrecipeService{
	@Autowired
	private MyrecipeDao myrecipeDao;
	@Autowired
	private LoginDao loginDao;
	@Autowired
	private TempMyrecipeDao tempMyrecipeDao;
	
	//한 페이지에 나타낼 row 의 갯수
	final int PAGE_ROW_COUNT=8; //프로젝트 상황에 맞게끔 변경가능
	//하단 디스플레이 페이지 갯수
	final int PAGE_DISPLAY_COUNT=5; //프로젝트 상황에 맞게끔 변경가능
	
	//나만의 조리법 페이지 리스트를 가져오는 메소드
	@Override
	public List<MyrecipeDto> getRecipeList(HttpServletRequest request) {
		
		//보여줄 페이지의 번호
		int pageNum=1;
		//보여줄 페이지의 번호가 파라미터로 전달되는지 읽어와 본다.	
		String strPageNum=request.getParameter("pageNum");
		if(strPageNum != null){//페이지 번호가 파라미터로 넘어온다면
			//페이지 번호를 설정한다.
			pageNum=Integer.parseInt(strPageNum);
		}
		//보여줄 페이지 데이터의 시작 ResultSet row 번호
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		//보여줄 페이지 데이터의 끝 ResultSet row 번호
		int endRowNum=pageNum*PAGE_ROW_COUNT;
		/*
			검색 키워드에 관련된 처리
		*/
		String keyword="";
		try {
			keyword = URLDecoder.decode(request.getParameter("keyword"),"UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String condition = request.getParameter("condition");
		if(keyword == null){//전달된 키워드가 없다면
			//condition, keyword의 파라미터값이 null이 찍히지 않도록 하기 위함.(파라미터로 넘어오는 값이 null로 찍힐 경우 문제가 생길 수도 있다고 함.)
			keyword = ""; //빈 문자열을 넣어준다.
			condition = ""; //빈 문자열을 넣어준다.
		}
		
		//keyword 변수의 내용을 파라미터로 전송할 때 인코딩된 키워드로 보내기 위함.
		//인코딩안된 내용을 파라미터로 보내면 문제가 발생할 수도 있다.
		//인코딩된 키워드를 미리 만들어 둔다.
		String encodedK = URLEncoder.encode(keyword);
		
		//keyword와 condition 변수에 null값이 들어오는지 확인용.
		//request.getParameter("keyword"), request.getParameter("keyword")의 값이 없는 경우 null값이 들어간다.
		System.out.println(keyword);
		System.out.println(condition);
		
		//검색 키워드와 startRowNum, endRowNum 을 담을 CafeDto 객체 생성
		MyrecipeDto dto = new MyrecipeDto();
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);
		
		if(!keyword.equals("")){ //만일 키워드가 넘어온다면
			if(condition.equals("title_content")){
				//검색 키워드를 CafeDto 객체의 필드에 담는다.
				dto.setTitle(keyword);
				dto.setContent(keyword);
			}else if(condition.equals("title")){
				dto.setTitle(keyword);
			}else if(condition.equals("writer")){
				dto.setWriter(keyword);
			}
		}
		//카페 목록 얻어오기
		List<MyrecipeDto> list = myrecipeDao.getList(dto);
		
		return list;
		
		/*
		//로그인 된 아이디 읽어오기 (로그인을 하지 않으면 null 이다)
		String id=(String)request.getSession().getAttribute("id");
		
		//한 페이지에 나타낼 row 의 갯수
		final int PAGE_ROW_COUNT=8;
		//하단 디스플레이 페이지 갯수
		final int PAGE_DISPLAY_COUNT=5;

		
		//보여줄 페이지의 번호
		int pageNum=1;
		//보여줄 페이지의 번호가 파라미터로 전달되는지 읽어와 본다.	
		String strPageNum=request.getParameter("pageNum");
		if(strPageNum != null){//페이지 번호가 파라미터로 넘어온다면
			//페이지 번호를 설정한다.
			pageNum=Integer.parseInt(strPageNum);
		}
		//보여줄 페이지 데이터의 시작 ResultSet row 번호
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		//보여줄 페이지 데이터의 끝 ResultSet row 번호
		int endRowNum=pageNum*PAGE_ROW_COUNT;
		
			//검색 키워드에 관련된 처리 
		
		String keyword=request.getParameter("keyword"); //검색 키워드
		String condition=request.getParameter("condition"); //검색 조건
		if(keyword==null){//전달된 키워드가 없다면 
			keyword=""; //빈 문자열을 넣어준다. 
			condition="";
		}
		//인코딩된 키워드를 미리 만들어 둔다. 
		String encodedK=URLEncoder.encode(keyword);
		
		//검색 키워드와 startRowNum, endRowNum 을 담을 FileDto 객체 생성
		MyrecipeDto dto=new MyrecipeDto();
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);
		//select 된 결과를 담을 List
		List<MyrecipeDto> list=null;
		//전체 row 의 갯수를 담을 변수 
		int totalRow=0;
		if(!keyword.equals("")){ //만일 키워드가 넘어온다면 
			if(condition.equals("title_content")){
				//검색 키워드를 FileDto 객체의 필드에 담는다. 
				dto.setTitle(keyword);
				dto.setContent(keyword);
				//검색 키워드에 맞는 파일 목록 중에서 pageNum 에 해당하는 목록 얻어오기
				list=myrecipeDao.getList(dto);
				//검색 키워드에 맞는 전체 글의 갯수를 얻어온다. 
				totalRow=myrecipeDao.getCount(dto);
			}else if(condition.equals("title")){
				dto.setTitle(keyword);
				list=myrecipeDao.getList(dto);
				totalRow=myrecipeDao.getCount(dto);
			}else if(condition.equals("writer")){
				dto.setWriter(keyword);
				list=myrecipeDao.getList(dto);
				totalRow=myrecipeDao.getCount(dto);
			}
		}else{//검색 키워드가 없으면 전체 목록을 얻어온다.
			list=myrecipeDao.getList(dto);
			totalRow=myrecipeDao.getCount(dto);
		}	
		//전체 페이지의 갯수 구하기
		int totalPageCount=
				(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
		//시작 페이지 번호
		int startPageNum=
			1+((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
		//끝 페이지 번호
		int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
		//끝 페이지 번호가 잘못된 값이라면 
		if(totalPageCount < endPageNum){
			endPageNum=totalPageCount; //보정해준다. 
		}
		*/
	}
	//나만의 조리법 페이지 페이징 처리 요청 관련 메소드
	@Override
	public Map<String, Object> getPagingList(HttpServletRequest request) {
		//보여줄 페이지의 번호
		int pageNum=1;
		//보여줄 페이지의 번호가 파라미터로 전달되는지 읽어와 본다.	
		String strPageNum=request.getParameter("pageNum");
		if(strPageNum != null){//페이지 번호가 파라미터로 넘어온다면
			//페이지 번호를 설정한다.
			pageNum=Integer.parseInt(strPageNum);
		}
		//보여줄 페이지 데이터의 시작 ResultSet row 번호
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		//보여줄 페이지 데이터의 끝 ResultSet row 번호
		int endRowNum=pageNum*PAGE_ROW_COUNT;
		
		//검색 키워드에 관련된 처리
		String keyword="";
		try {
			keyword = URLDecoder.decode(request.getParameter("keyword"),"UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String condition=request.getParameter("condition"); //검색 조건
		if(keyword==null){//전달된 키워드가 없다면 
			keyword=""; //빈 문자열을 넣어준다. 
			condition="";
		}
		//인코딩된 키워드를 미리 만들어 둔다. 
		String encodedK=URLEncoder.encode(keyword);
		
		//MyrecipeDto 객체 생성
		MyrecipeDto dto = new MyrecipeDto();
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);
		
		//전체 row 의 갯수를 담을 totalRow 변수 
		int totalRow=0;
		if(!keyword.equals("")){ //만일 키워드가 넘어온다면 
			if(condition.equals("title_content")){
				//검색 키워드를 MyrecipeDto 객체의 필드에 담는다. 
				dto.setTitle(keyword);
				dto.setContent(keyword);
				//검색 키워드에 맞는 전체 글의 갯수를 얻어온다. 
				totalRow=myrecipeDao.getCount(dto);
			}else if(condition.equals("title")){
				dto.setTitle(keyword);
				totalRow=myrecipeDao.getCount(dto);
			}else if(condition.equals("writer")){
				dto.setWriter(keyword);
				totalRow=myrecipeDao.getCount(dto);
			}
		}else{//검색 키워드가 없으면 전체 글의 개수를 얻어온다.
			totalRow=myrecipeDao.getCount(dto);
		}
		
		//하단에 표시할 전체 페이지의 갯수 구하기
		int totalPageCount=
				(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT); //double 연산으로 소수점이 나오는데 이것을 올림 연산(Math.ceil)을 해서 전체 행의 개수에 맞는 하단에 표시할 전체 페이지의 개수를 구하기 위함.
		//시작 페이지 번호
		int startPageNum=
			1+((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
		//끝 페이지 번호
		int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
		//끝 페이지 번호가 잘못된 값이라면(실제 하단 페이지 개수(totalPageCount)보다 끝 페이지 번호 계산된 값(endPageNum)이 많다면)
		if(totalPageCount < endPageNum){
			endPageNum=totalPageCount; //보정해준다.(실제 하단 페이지 개수로 화면에 출력될 수 있도록 endPageNum의 값을 totalPageCount로 넣어준다.)
		}
		//페이징 처리의 데이터를 담을 Map 객체 생성.
		Map<String, Object> pagingMap = new HashMap<>();
		//페이징 처리에 필요한 데이터 담기
		pagingMap.put("totalRow", totalRow);
		pagingMap.put("totalPageCount", totalPageCount);
		pagingMap.put("startPageNum", startPageNum);
		pagingMap.put("endPageNum", endPageNum);
		pagingMap.put("pageNum", pageNum);
		pagingMap.put("keyword", encodedK);
		pagingMap.put("condition", condition);
		
		return pagingMap;
	}
	//레시피 작성하기 폼 요청 관련 메소드
	@Override
	public Map<String, Object> getAjaxData(HttpSession session, ModelAndView mView) {
		//1. GET 방식 파라미터로 전달되는 글번호를 읽어온다.
		String id=(String)session.getAttribute("id");
		//2. DB 에서 해당 글 정보를 얻어온다.
		LoginDto dto=loginDao.getData(id);
		//이미지 표시할 준비를 한다.
		MyrecipeDto recipe_dto = myrecipeDao.getWriteData(id);
		//임시 저장된 내용을 표시할 준비를 한다.
		TempMyrecipeDto temp_dto = tempMyrecipeDao.getTempWriteData(id);
		
		//map 객체에 dto 정보들을 담는다.
		Map<String, Object> dtoData = new HashMap<>();
		dtoData.put("dto", dto);
		dtoData.put("recipe_dto", recipe_dto);
		dtoData.put("temp_dto", temp_dto);
		
		return dtoData;
	}
	//레시피 저장하기 요청 관련 메소드
	@Override
	public void saveRecipe(MyrecipeDto dto, HttpServletRequest request, ModelAndView mView) {
		//아이디 정보를 가져온다.
		String id = (String)request.getSession().getAttribute("id");
		//myrecipeDao 를 통해 dto 값 저장한 후 성공유무를 isSuccess 변수에 담는다.
		boolean isSuccess = myrecipeDao.insert(dto);
		//mView 객체에 isSuccess의 값을 저장한다.
		mView.addObject("isSuccess", isSuccess);
		mView.addObject("writer", id);
	}
	//대표 이미지 업로드 요청 관련 메소드
	@Override
	public Map<String, Object> showImageUpload(MultipartFile image, HttpServletRequest request) {
		//업로드된 파일의 정보를 가지고 있는 MultipartFile 객체의 참조값 얻어오기
		MultipartFile myFile = image;
		//원본 파일명과 파일의 크기를 알아낸다.
		//원본 파일명
		String orgFileName = myFile.getOriginalFilename();
		//파일의 크기
		long fileSize = myFile.getSize();
		
		//임시 폴더에 있는 파일을 upload 폴더에 옮겨야한다.
		// webapp/upload 폴더 까지의 실제 경로(서버의 파일 시스템 상에서의 경로)
		String realPath = request.getServletContext().getRealPath("/upload");
		//저장할 파일의 상세 경로
		String filePath = realPath+File.separator;
		//디렉토리를 만들 파일 객체 생성
		File upload = new File(filePath);
		if(!upload.exists()) {//만일 디렉토리가 존재하지 않으면
			upload.mkdir(); //만들어 준다.
		}
		//저장할 파일 명을 구성한다.
		String saveFileName = 
				System.currentTimeMillis()+orgFileName;
		//이미지 파일이 저장된 경로
	    String imageSrc = "/upload/"+saveFileName;
	    
		try {
			//upload 폴더에 파일을 저장한다.
			//(서버의 파일 시스템 상에서의 경로+File.separator(filePath)와 저장된 파일 이름(saveFileName)의 정보를 가진 파일 객체를 생성한 후에 transferTo 함수의 인자로 던져주면 내부적으로 임시 폴더에 있던 파일을 upload 폴더에 옮겨준다(저장해준다))
			myFile.transferTo(new File(filePath+saveFileName));
			System.out.println(filePath+saveFileName);
		}catch(Exception e) {
			e.printStackTrace();
		}
		//session 영역에 선택한 프로필이 저장된 물리적인 경로를 저장한다.
		request.getSession().setAttribute(orgFileName, filePath+saveFileName);
		//session 영역에 저장된 이전의 프로필 정보들을 가져온다.
		Enumeration<String> filePaths = request.getSession().getAttributeNames();
	    //filePaths가 존재하는 동안 반복.
		while(filePaths.hasMoreElements()){
		    String fileName = filePaths.nextElement();
		    String file_path = (String)request.getSession().getAttribute(fileName);
		    //선택한 프로필의 원본 파일명과 session에 저장된 원본 파일명이 같지 않은 경우
		    if(!orgFileName.equals(fileName)) {
			    //upload 폴더 내에 있는 파일을 삭제한다.
		    	//파일 객체 생성 후 파일 삭제
		    	File file = new File(file_path);
		    	if(file.exists()){
		    		if(file.delete()){
		    			System.out.println("삭제 성공!");
		    		}else{
		    			System.out.println("삭제 실패..");
		    		}
		    	}else{ 
		    		System.out.println("파일이 존재하지 않습니다.");
		    	}
		    }
		    System.out.println(fileName + " : " + file_path);
		}
	    
	    //이미지 경로와 저장된 파일이름을 mView에 담는다.
	    Map<String, Object> resultValue = new HashMap<>();
	    resultValue.put("imageSrc", imageSrc);
	    resultValue.put("showImage", saveFileName);
	    //리턴한다.
	    return resultValue;	
	}
}
