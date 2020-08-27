package com.spring.project.login.service;

import java.net.URLEncoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.spring.project.login.dao.LoginDao;
import com.spring.project.login.dto.LoginDto;

@Service
public class LoginServiceImpl implements LoginService{
	@Autowired
	private LoginDao loginDao;

	@Override
	public void getLoginInfo(HttpServletRequest request, ModelAndView mView) {
		//로그인된 아이디가 있는지 가져와본다.
		String id=(String)request.getSession().getAttribute("id");
		//로그인된 정보를 dto에 담는다.
		LoginDto dto = loginDao.getData(id);
		//view 페이지에서 사용하기 위해서 ModelAndView 객체에 dto를 담는다.
		mView.addObject("dto", dto);
	}
	//저장된 쿠키 정보를 가져오는 메소드
	@Override
	public ModelAndView getCookie(HttpServletRequest request, ModelAndView mView) {
		//쿠키에 저장된 아이디와 비밀번호를 담을 변수
		String savedId="";
		String savedPwd="";
		//쿠키에 저장된 값을 위의 변수에 저장하는 코드를 작성해 보세요.
		Cookie[] cooks=request.getCookies();
		if(cooks!=null){
			//반복문 돌면서 쿠키객체를 하나씩 참조해서 
			for(Cookie tmp: cooks){
				//저장된 키값을 읽어온다.
				String key=tmp.getName();
				//만일 키값이 savedId 라면 
				if(key.equals("savedId")){
					//쿠키 value 값을 savedId 라는 지역변수에 저장
					savedId=tmp.getValue();
				}
				if(key.equals("savedPwd")){
					savedPwd=tmp.getValue();
				}
			}
		}
		//쿠키 정보를 ModelAndView 객체에 저장.
		mView.addObject("savedId", savedId);
		mView.addObject("savedPwd", savedPwd);
		
		return mView;
	}
	//로그인을 처리하는 메소드
	@Override
	public void loginProcess(LoginDto dto, HttpServletRequest request,
			HttpServletResponse response, ModelAndView mView) {
		//아이디 비번을 저장하는 쿠키
		//체크박스를 체크 하지 않았으면 null 이다. 
		String isSave=request.getParameter("isSave");
		
		if(isSave == null){//체크 박스를 체크 안했다면
			//저장된 쿠키 삭제 
			Cookie idCook=new Cookie("savedId", dto.getId());
			idCook.setMaxAge(0);//삭제하기 위해 0 으로 설정 
			response.addCookie(idCook);
			
			Cookie pwdCook=new Cookie("savedPwd", dto.getPwd());
			pwdCook.setMaxAge(0);
			response.addCookie(pwdCook);
		}else{//체크 박스를 체크 했다면 
			//아이디와 비밀번호를 쿠키에 저장
			Cookie idCook=new Cookie("savedId", dto.getId());
			idCook.setMaxAge(60*60*24);//60초동안 유지  60*60은 한시간 60*60*24 하루
			response.addCookie(idCook);
			
			Cookie pwdCook=new Cookie("savedPwd", dto.getPwd());
			pwdCook.setMaxAge(60*60*24);
			response.addCookie(pwdCook);
		}
		
		//입력한 정보가 유효한 정보인지 여부를 저장할 지역변수
		boolean isValid = false;
		//로그인 폼에 입력한 아이디를 이용해서 DB에서 select 해본다.
		//존재하지 않는 아이디면 null 이 리턴된다.
		LoginDto resultDto = loginDao.getData(dto.getId());
		
		if(resultDto != null) { //아이디는 존재하는 경우
			//DB에 저장된 암호화된 비밀번호
			String encodedPwd = resultDto.getPwd();
			//로그인 폼에 입력한 비밀번호
			String inputPwd = dto.getPwd();
			//Bcrypt 클래스의 static 메소드로 DB에 저장된 암호화된 비밀번호와 입력한 비밀번호의 일치 여부를 검사한다.
			isValid = BCrypt.checkpw(inputPwd, encodedPwd);
		}
		
		if(isValid) { //만약 유효한 정보라면
			//로그인 처리를 한다.
			request.getSession().setAttribute("id", dto.getId());
			//view 페이지에서 사용할 정보(view 페이지에서 로그인 성공유무에 따라 다른 결과를 보여주기 위한 정보) 
			mView.addObject("isSuccess", true);
		}else {
			mView.addObject("isSuccess", false);
		}
	}
	@Override
	public void addUser(LoginDto dto, ModelAndView mView) {
		//비밀번호를 암호화할 BcryptPasswordEncoder 객체 생성.
		BCryptPasswordEncoder pe = new BCryptPasswordEncoder();
		//dto에 있는 입력된 비밀번호 암호화해서 다시 dto의 pwd 필드에 넣는다.
		dto.setPwd(pe.encode(dto.getPwd()));
		// dao 객체를 이용해서 새로운 사용자 정보를 DB에 저장하기
		loginDao.insert(dto, mView);
	}
	@Override
	public void updateUserPwd(LoginDto dto, HttpServletRequest request, ModelAndView mView) {
		//세션 영역에서 아이디 읽어오기
		String id=(String)request.getSession().getAttribute("id");
		//LoginDto 객체에 세션에 있는 id를 담는다.
		dto.setId(id);
		
		//DB에 저장된 암호화된 비밀번호와 기존 비밀번호가 일치하는 지 확인하고 일치하면 새로운 비밀번호를 암호화해서 DB에 저장.
		//작업 성공여부
		boolean isSuccess = false;
		//1. DB에 저장된 비밀번호를 읽어온다.
		LoginDto resultDto = loginDao.getData(id);
		//2. DB에 암호화해서 저장된 비밀번호와 기존 비밀번호가 일치하는 지 확인.
		isSuccess = BCrypt.checkpw(dto.getPwd(), resultDto.getPwd());
		if(isSuccess) {//isSuccess가 true 일 경우(기존 비밀번호와 암호화된 비밀번호가 같을 경우)
			//새로운 비밀번호를 암호화한다.
			BCryptPasswordEncoder pe = new BCryptPasswordEncoder();
			String encodedNewPwd = pe.encode(dto.getNewPwd());
			//암호화된 새 비밀번호를 dto 에 다시 넣어준다.
			dto.setNewPwd(encodedNewPwd);
			//dao 를 이용해서 DB 에 반영한다.
			loginDao.updatePwd(dto);
		}
		//mView 객체에 성공 여부를 담는다.
		mView.addObject("isSuccess", isSuccess);
	}
}
