package com.spring.project.myrecipe.service;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.spring.project.myrecipe.dao.MyrecipeDao;
import com.spring.project.myrecipe.dto.MyrecipeDto;

@Service
public class MyrecipeServiceImpl implements MyrecipeService{
	@Autowired
	private MyrecipeDao myrecipeDao;
	
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
}
