package cs.dit.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.github.scribejava.core.model.OAuth2AccessToken;

import cs.dit.model.MemberVO;
import cs.dit.service.MemberService;
import cs.dit.snstest.NaverLoginBO;
import lombok.extern.log4j.Log4j;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping(value="/member")
@Log4j
public class MemberController {
	
		private static final Logger log = LoggerFactory.getLogger(MemberController.class);

	
		/* NaverLoginBO */
		private NaverLoginBO naverLoginBO;
		private String apiResult = null;
		
		@Autowired
		private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
			this.naverLoginBO = naverLoginBO;
		}
		
		@Autowired
		private MemberService memberservice;
		
		@Autowired
	    private BCryptPasswordEncoder pwEncoder;
		
		
		//메인페이지 이동
		@RequestMapping(value = "main", method = RequestMethod.GET)
		public String mainGET() {
							
			log.info("메인 페이지 진입");
			
			return "redirect:/";

		}
		
		//회원가입 페이지 이동
		@RequestMapping(value = "join", method = RequestMethod.GET)
		public void joinGET() {
			
			log.info("회원가입 페이지 진입");
			
		}
		
		//회원가입
		@RequestMapping(value="/join", method=RequestMethod.POST)
		public String joinPOST(MemberVO member) throws Exception{
			
			log.info("join 진입"); 
			
			String rawPw = "";            // 인코딩 전 비밀번호
		    String encodePw = ""; 
		     
		    rawPw = member.getMemberPw();            // 비밀번호 데이터 얻음
		    encodePw = pwEncoder.encode(rawPw);        // 비밀번호 인코딩
		    member.setMemberPw(encodePw);    

			// 회원가입 서비스 실행
			memberservice.memberJoin(member);
			
			log.info("join Service 성공");
			
			return "redirect:/";
			
		}

		// 아이디 중복 검사
		@RequestMapping(value = "/memberIdChk", method = RequestMethod.POST)
		@ResponseBody
		public String memberIdChkPOST(String memberId) throws Exception{
			
			log.info("memberIdChk() 진입");
			int result = memberservice.idCheck(memberId);
			log.info("결과값 = " + result);			
			if(result != 0) {				
				return "fail";	// 중복 아이디가 존재 : 1				
			} else {				
				return "success";	// 중복 아이디 x : 0				
			}				
		} // memberIdChkPOST() 종료
		
		
		// 이메일 중복 검사
		@RequestMapping(value = "/memberEmailChk", method = RequestMethod.POST)
		@ResponseBody
		public String memberEmailChkPOST(String memberEmail) throws Exception{
			
			log.info("memberEmailChk() 진입");
			int result = memberservice.emailCheck(memberEmail);
			log.info("결과값 = " + result);			
			if(result != 0) {				
				return "fail";	// 중복 이메일 존재 : 1				
			} else {				
				return "success";	// 중복 이메일 x : 0				
			}				
		} // memberEmailChkPOST() 종료
		
		//로그인 페이지 이동
		@RequestMapping(value = "login", method = RequestMethod.GET)
		public void loginGET() {
			
			log.info("로그인 페이지 진입");
			
		}
		
		 /* 로그인 */
	    @RequestMapping(value="login", method=RequestMethod.POST)
	    public String loginPOST(HttpServletRequest request, MemberVO member,RedirectAttributes rttr, Model model,HttpServletResponse response) throws Exception{  
	    	
	    	 HttpSession session = request.getSession();
	    	 String rawPw = "";
	         String encodePw = "";
	         MemberVO lvo = memberservice.memberLogin(member);
	         
	    	
	         if(lvo != null) {                        // 일치하는 아이디 존재시
	             
	             rawPw = member.getMemberPw();        // 사용자가 제출한 비밀번호
	             encodePw = lvo.getMemberPw();        // 데이터베이스에 저장한 인코딩된 비밀번호
	             
	             if(true == pwEncoder.matches(rawPw, encodePw)) {        // 비밀번호 일치여부 판단
	                 
	                 lvo.setMemberPw("");                     // 인코딩된 비밀번호 정보 지움
	                 session.setAttribute("member", lvo);     // session에 사용자의 정보 저장
	                 
	              // 쿠키를 생성하고 현재 로그인되어 있을 때 생성되었던 세션의 id를 쿠키에 저장한다.
	                 Cookie cookie = new Cookie("loginCookie", session.getId());
	                 // 쿠키를 찾을 경로를 컨텍스트 경로로 변경해 주고...
	                 cookie.setPath("/");
	                 cookie.setMaxAge(60*60*24*7); // 단위는 (초)임으로 7일정도로 유효시간을 설정해 준다.
	                 // 쿠키를 적용해 준다.
	                 response.addCookie(cookie); 
	         	                 
	                 return "redirect:/";                     // 메인페이지 이동
	                 
	                 
	             } else {
	  
	                 rttr.addFlashAttribute("result", 0);            
	                 return "redirect:/member/login";    // 로그인 페이지로 이동
	                 
	             }
	             
	         } else {                    // 일치하는 아이디가 존재하지 않을 시 (로그인 실패)
	             
	             rttr.addFlashAttribute("result", 0);            
	             return "redirect:/member/login";    // 로그인 페이지로 이동
	             
	         }
            
	    }
	    
	    /* 로그아웃 */
	    @RequestMapping(value="logout.do", method=RequestMethod.GET)
	    public String logoutMainGET(HttpServletRequest request) throws Exception{
	        
	        log.info("logoutMainGET메서드 진입");
	        
	        HttpSession session = request.getSession();
	        
	        session.invalidate();
	        
	        return "redirect:/";    
	          
	    }
	    
		//소셜 로그인 페이지 이동
		@RequestMapping(value = "snsLogin", method = RequestMethod.GET)
		public void snsLoginGET() {
			
			log.info("소셜 로그인 페이지 진입");
			
		}
		
		//구글 로그인 페이지 이동
		@RequestMapping(value = "googlelogin", method = RequestMethod.GET)
		public void snsgoogleLoginGET() {
					
			log.info("소셜 로그인 페이지 진입");
					
		}
	    
	    /* 네이버 로그인 버튼 눌렀을 때*/
		//소셜 로그인 첫 화면 요청 메소드
		@RequestMapping(value = "snslogin", method = { RequestMethod.GET, RequestMethod.POST })
		public String login(Model model, HttpSession session) {
			
			/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
			String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
			
			//https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
			//redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
			System.out.println("네이버:" + naverAuthUrl);
			
			//네이버 
			model.addAttribute("url", naverAuthUrl);
	 
			return "/member/snslogin";
		}
	 
		//네이버 로그인 성공시 callback호출 메소드
		@RequestMapping(value = "/callback", method = { RequestMethod.GET, RequestMethod.POST })
		public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session,HttpServletResponse response) throws Exception {
			
			
			System.out.println("여기는 callback");
			OAuth2AccessToken oauthToken;
	        oauthToken = naverLoginBO.getAccessToken(session, code, state);
	 
	        //1. 로그인 사용자 정보를 읽어온다.
			apiResult = naverLoginBO.getUserProfile(oauthToken);  //String형식의 json데이터
			
			//2. String형식인 apiResult를 json형태로 바꿈
			JSONParser parser = new JSONParser();
			Object obj = parser.parse(apiResult);
			JSONObject jsonObj = (JSONObject) obj;
			
			//3. 데이터 파싱 
			//Top레벨 단계 _response 파싱
			JSONObject response_obj = (JSONObject)jsonObj.get("response");
			//response의 nickname값 파싱
			String memberName = (String)response_obj.get("name");
			String memberEmail = (String)response_obj.get("email");
			String memberTel = (String)response_obj.get("mobile");
			
			System.out.println(memberName);
			System.out.println(memberEmail);
			System.out.println(memberTel);
			
			MemberVO member = new MemberVO();
			member.setMemberEmail(memberEmail);		//회원 이메일

			//이메일 존재유무 파악
			int result = memberservice.emailCheck(memberEmail);
			
			
			if(result != 0) {				//존재하는 이메일 경우	
				
				//소셜 계정 로그인 서비스
				MemberVO lvo = memberservice.memberSnsLogin(member);
				session.setAttribute("member",lvo); 
				session.setAttribute("memberName",memberName);   //세션 생성
				session.setAttribute("memberEmail",memberEmail); //세션 생성
				model.addAttribute("result", apiResult);   
				
                return "redirect:/";                     // 메인페이지 이동	
				
			} else {			//존재하지 않는 이메일 경우	
				
				//값을 가져와 회원가입 페이지로 이동
				member.setMemberName(memberName);		//회원 이름
				member.setMemberTel(memberTel);			//회원 전화번호
				member.setMemberEmail(memberEmail);		//회원 이메일

				//4.파싱 닉네임 세션으로 저장
				session.setAttribute("memberName",memberName);   //세션 생성
				session.setAttribute("memberEmail",memberEmail); //세션 생성
				session.setAttribute("memberTel",memberTel);     //세션 생성

				model.addAttribute("result", apiResult);    
				return "redirect:/member/snsJoin";		    //소셜 로그인용 회원가입 페이지
				
			}	

		}
		
		/* 구글아이디 로그인 */	
		@ResponseBody
		@RequestMapping(value = "/loginGoogle", method = RequestMethod.POST)
		public String loginGooglePOST(Model model, HttpSession session,HttpServletResponse response, MemberVO mvo) throws Exception{

			String memberEmail = mvo.getMemberEmail(); 
			String memberName = mvo.getMemberName();  

			System.out.println("C: 구글아이디 포스트 ajax에서 가져온 email:  "+ memberEmail);
			System.out.println("C: 구글아이디 포스트 ajax에서 가져온 name:  "+ memberName);
			
			
			MemberVO member = new MemberVO();
			member.setMemberEmail(memberEmail);		//회원 이메일

			//이메일 존재유무 파악
			int result = memberservice.emailCheck(memberEmail);
			
			
			if(result != 0) {				//존재하는 이메일 경우	
				
				System.out.println("구글 로그인 : 존재하는 이메일");
				
				//소셜 이메일 로그인 서비스
				MemberVO lvo = memberservice.memberSnsLogin(member);
				session.setAttribute("member",lvo); 
				session.setAttribute("memberName",memberName);   //세션 생성
				session.setAttribute("memberEmail",memberEmail); //세션 생성
				model.addAttribute("result", apiResult);   
				
                return "mainPage";                     // 메인페이지 이동	
				
			} else {			//존재하지 않는 이메일 경우	
				
				System.out.println("구글 로그인 : 존재하지 않는 이메일");
				
				//값을 가져와 회원가입 페이지로 이동
				member.setMemberName(memberName);		//회원 이름
				member.setMemberEmail(memberEmail);		//회원 이메일

				//4.파싱 닉네임 세션으로 저장
				session.setAttribute("memberName",memberName);   //세션 생성
				session.setAttribute("memberEmail",memberEmail); //세션 생성

				model.addAttribute("result", apiResult);    
				return "joinPage";		    //소셜 로그인용 회원가입 페이지
				
			}	
			

		}
	    
		
		//소셜 회원가입 페이지 이동
		@RequestMapping(value = "snsJoin", method = RequestMethod.GET)
		public void snsJoinGET() {
					
			log.info("소셜회원가입 페이지 진입");
					
		}
				
		//소셜 회원가입
		@RequestMapping(value="/snsJoin", method=RequestMethod.POST)
		public String snsJoinPOST(MemberVO member) throws Exception{
					
			log.info("join 진입"); 
					
			String rawPw = "";            // 인코딩 전 비밀번호
			String encodePw = ""; 
				     
			rawPw = member.getMemberPw();            // 비밀번호 데이터 얻음
			encodePw = pwEncoder.encode(rawPw);        // 비밀번호 인코딩
			member.setMemberPw(encodePw);    

			// 회원가입 서비스 실행
			memberservice.memberJoin(member);
					
			log.info("join Service 성공");
					
			return "redirect:/";
					
		}

	    
		//마이페이지 이동
		@RequestMapping(value = "mypage", method = RequestMethod.GET)
		public void mypageGET(HttpSession session, Model model, String id) {
					
			log.info("마이페이지 페이지 진입");
			
			model.addAttribute("member", memberservice.readMember(id));
					
		}
		
		//회원정보수정 페이지 이동
		@RequestMapping(value = "modify", method = RequestMethod.GET)
		public void modifyGET(String id, Model model) {
							
			log.info("회원정보수정 페이지 진입");

		}
		
		//회원정보수정 
		@RequestMapping(value="/modify", method=RequestMethod.POST)
		public String modifyPOST(MemberVO member, HttpServletRequest request) throws Exception{
			
			log.info("modify 진입");
			
			HttpSession session = request.getSession();  //세션
			String rawPw = "";            // 인코딩 전 비밀번호
		    String encodePw = ""; 
		     
		    rawPw = member.getMemberPw();            // 비밀번호 데이터 얻음
		    encodePw = pwEncoder.encode(rawPw);        // 비밀번호 인코딩
		    member.setMemberPw(encodePw);    

			memberservice.memberModify(member);
			
			MemberVO lvo = memberservice.memberLogin(member);    //수정된 회원정보로 세션값 변경
			session.setAttribute("member", lvo);
			
			log.info("회원정보수정 완료");
			
			return "redirect:/";
			
		}
		
		// 임시비밀번호발급 페이지 이동
		@RequestMapping(value = "findpw", method = RequestMethod.GET)
		public void findPwGET() throws Exception{
			
			log.info("임시비밀번호 페이지 진입");
		}
		
		// 임시비밀번호 발급
		@RequestMapping(value = "/findpw", method = RequestMethod.POST)
		public void findPwPOST(@ModelAttribute MemberVO member, HttpServletResponse response) throws Exception{
			
			System.out.println("입력받은 이메일 값 : "+ member.getMemberEmail());
			
			//임시 비밀번호 발급
			response.setContentType("text/html;charset=utf-8");
	 		MemberVO ck = memberservice.readMember(member.getMemberId());
	 		PrintWriter out = response.getWriter();
	 	
	 		// 가입된 아이디가 없으면
	 		if(memberservice.idCheck(member.getMemberId()) == 0) {
	 			
	 			out.print("등록되지 않은 아이디입니다.");
	 			out.close();
	 			log.info("등록되지 않은 아이디로 시도");
	 			
	 		}// 가입된 이메일이 아니면
	 		else if(!member.getMemberEmail().equals(ck.getMemberEmail())) {
	 			
	 			out.print("등록되지 않은 이메일입니다.");
	 			out.close();
	 			log.info("등록되지 않은 이메일로 시도");
	 			
	 		}else {
	 			
	 			//임시 비밀번호  
	 			String pw = "";         
	 			String encodePw = "";  //인코딩 비밀번호
	 			
	 			//임시 비밀번호 생성
	 			for (int i = 0; i < 12; i++) {          
	 				pw += (char) ((Math.random() * 26) + 97);
	 			}
	 			
	 			//비밀번호 셋팅
	 			member.setMemberPw(pw);
	 			memberservice.sendEmail(member, "findpw");
	 			
	 			 // 비밀번호 인코딩
			    encodePw = pwEncoder.encode(pw);
			    member.setMemberPw(encodePw);    
	 			memberservice.updatePw(member);

	 			
	 			out.print("이메일로 임시 비밀번호를 발송하였습니다. <br> 로그인 후 비밀번호를 변경해 주세요.");
	 			out.close();
	 			log.info("임시 비밀번호 발급 서비스 완료");
	 				
	 		}

		}
		
		// 회원탈퇴
	    @RequestMapping(value="/delete.do", method=RequestMethod.POST)
	    public String deleteGET(MemberVO member, HttpServletRequest request) throws Exception{
	          
	        memberservice.memberDelete(member);
	        
	        log.info("회원탈퇴 완료");
	        
	        HttpSession session = request.getSession();
	        
	        session.invalidate();
	        
	        log.info("세션끊기 완료");
	        
	        return "redirect:/";    
	        
	        
	    }
		

		
	
}
