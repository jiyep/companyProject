package cs.dit.service;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cs.dit.mapper.MemberMapper;
import cs.dit.model.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberMapper membermapper;
	
	// 회원가입
	@Override
	public void memberJoin(MemberVO member) throws Exception {
		membermapper.memberJoin(member);
	}

	// 아이디 중복 검사
	@Override
	public int idCheck(String memberId) throws Exception {
		
		return membermapper.idCheck(memberId);
	}
	
	// 이메일 중복 검사
	@Override
	public int emailCheck(String memberEmail) throws Exception {
		
		return membermapper.emailCheck(memberEmail);
	}
	
	// 로그인
    @Override
    public MemberVO memberLogin(MemberVO member) throws Exception {

        return membermapper.memberLogin(member);
    }
    
    // 소셜 로그인
    @Override
    public MemberVO memberSnsLogin(MemberVO member) {

        return membermapper.memberSnsLogin(member);
    }
  	
  	//회원정보보기
  	@Override
  	public MemberVO readMember(String id) {
  		System.out.println("S : readMember()실행");
  		MemberVO vo = null;
  		
  		try {
  			vo = membermapper.readMember(id);
  		} catch (Exception e) {
  			e.printStackTrace();
  		}
  		
  		return vo;
  	}
  	
    // 회원정보수정
 	@Override
 	public void memberModify(MemberVO member) throws Exception {
 		membermapper.memberModify(member);

 	}
 	
 	//비밀번호 찾기 이메일발송
 	public void sendEmail(MemberVO member, String div) throws Exception {
 		// Mail Server 설정
 		String charSet = "utf-8";
 		String hostSMTP = "smtp.naver.com"; //네이버 이용시 smtp.naver.com, google 이용시 smtp.gmail.com
 		String hostSMTPid = "qkrwldp1111";   
 		String hostSMTPpwd = "wldp19870811!";

 		// 보내는 사람 EMail, 제목, 내용
 		String fromEmail = "qkrwldp1111@naver.com";
 		String fromName = "ADMINs";
 		String subject = "";
 		String msg = "";

 		if(div.equals("findpw")) {
 			subject = "임시 비밀번호 입니다.";
 			msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
 			msg += "<h3 style='color: blue;'>";
 			msg += member.getMemberId() + "님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>";
 			msg += "<p>임시 비밀번호 : ";
 			msg += member.getMemberPw() + "</p></div>";
 		}

 		// 받는 사람 E-Mail 주소
 		String mail = member.getMemberEmail();
 		try {
 			HtmlEmail email = new HtmlEmail();
 			email.setDebug(true);
 			email.setCharset(charSet);
 			email.setSSL(true);
 			email.setHostName(hostSMTP);
 			email.setSmtpPort(587); //네이버 이용시 587, google 이용시 465

 			email.setAuthentication(hostSMTPid, hostSMTPpwd);
 			email.setTLS(true);
 			email.addTo(mail, charSet);
 			email.setFrom(fromEmail, fromName, charSet);
 			email.setSubject(subject);
 			email.setHtmlMsg(msg);
 			email.send();
 		} catch (Exception e) {
 			System.out.println("메일발송 실패 : " + e);
 		}
 	}
 	
 	//비밀번호 업데이트
 	@Override 	 
 	public int updatePw(MemberVO member) throws Exception{
 		return membermapper.updatePw(member);
 	}
 	 
 	//회원탈퇴
 	@Override
 	public void memberDelete(MemberVO member) throws Exception{
 		
 		membermapper.memberDelete(member);
 		
 	}
 	


}
