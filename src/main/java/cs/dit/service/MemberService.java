package cs.dit.service;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.parser.ParseException;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import cs.dit.model.MemberVO;

public interface MemberService {
	
	//회원가입
	public void memberJoin(MemberVO member)throws Exception;
	
	// 아이디 중복 검사
	public int idCheck(String memberId) throws Exception;
	
	// 이메일 중복 검사
	public int emailCheck(String memberEmail) throws Exception;
	
	// 로그인 
    public MemberVO memberLogin(MemberVO member) throws Exception;
    
    // 소셜 로그인 
    public MemberVO memberSnsLogin(MemberVO member);
    
    //회원정보수정
  	public void memberModify(MemberVO member)throws Exception;
  	
  	//이메일발송
  	public void sendEmail(MemberVO member, String div) throws Exception;
  	
  	//회원정보 보기
  	public MemberVO readMember(String id);

  	// 비밀번호 변경
    public int updatePw(MemberVO member) throws Exception;
  	
  	//회원탈퇴
  	public void memberDelete(MemberVO member) throws Exception;

  	



}
