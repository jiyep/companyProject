package cs.dit.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import cs.dit.model.MemberVO;
import cs.dit.service.MemberService;
import cs.dit.snstest.NaverLoginBO;
import lombok.extern.log4j.Log4j;


import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
 
import com.github.scribejava.core.model.OAuth2AccessToken;

@Controller
@RequestMapping(value="/member")
@Log4j
public class MemberController {
		
	
		/* NaverLoginBO */
		private NaverLoginBO naverLoginBO;
		private String apiResult = null;
		
		@Autowired
		private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
			this.naverLoginBO = naverLoginBO;
		}
		
		@Autowired
		private MemberService memberservice;
		
		//메인페이지 이동
		@RequestMapping(value = "main", method = RequestMethod.GET)
		public String mainGET() {
							
			log.info("메인 페이지 진입");
			
			return "redirect:/";

		}

		
		//회원가입 페이지 이동
		@RequestMapping(value = "join", method = RequestMethod.GET)
		public void loginGET() {
			
			log.info("회원가입 페이지 진입");
			
		}
		
		//회원가입
		@RequestMapping(value="/join", method=RequestMethod.POST)
		public String joinPOST(MemberVO member) throws Exception{
			
			log.info("join 진입"); 
			
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
				return "fail";	// 중복 아이디가 존재				
			} else {				
				return "success";	// 중복 아이디 x				
			}				
		} // memberIdChkPOST() 종료
		
		//로그인 페이지 이동
		@RequestMapping(value = "login", method = RequestMethod.GET)
		public void joinGET() {
			
			log.info("로그인 페이지 진입");
			
		}
		
		 /* 로그인 */
	    @RequestMapping(value="login", method=RequestMethod.POST)
	    public String loginPOST(HttpServletRequest request, MemberVO member,RedirectAttributes rttr) throws Exception{     
	    	
	        //System.out.println("login 메서드 진입");
	        //System.out.println("전달된 데이터 : " + member); 
	    	
	    	HttpSession session = request.getSession();
	    	MemberVO lvo = memberservice.memberLogin(member);	    	
	    	
	    	if(lvo == null) {                                // 일치하지 않는 아이디, 비밀번호 입력 경우
	            
	            int result = 0;
	            rttr.addFlashAttribute("result", result);
	            return "redirect:/member/login";
	            
	        }
	        
	        session.setAttribute("member", lvo);             // 일치하는 아이디, 비밀번호 경우 (로그인 성공)
	        
	        return "redirect:/";

	    }
	    
	    
	    /* 네이버 로그인*/
		//로그인 첫 화면 요청 메소드
		@RequestMapping(value = "Naverlogin", method = { RequestMethod.GET, RequestMethod.POST })
		public String login(Model model, HttpSession session) {
			
			/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
			String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
			
			//https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
			//redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
			System.out.println("네이버:" + naverAuthUrl);
			
			//네이버 
			model.addAttribute("url", naverAuthUrl);
	 
			return "/member/Naverlogin";
		}
	 
		//네이버 로그인 성공시 callback호출 메소드
		@RequestMapping(value = "/callback", method = { RequestMethod.GET, RequestMethod.POST })
		public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session) throws IOException, ParseException {
			
			System.out.println("여기는 callback");
			OAuth2AccessToken oauthToken;
	        oauthToken = naverLoginBO.getAccessToken(session, code, state);
	 
	        //1. 로그인 사용자 정보를 읽어온다.
			apiResult = naverLoginBO.getUserProfile(oauthToken);  //String형식의 json데이터
			
			/** apiResult json 구조
			{"resultcode":"00",
			 "message":"success",
			 "response":{"id":"33666449","nickname":"shinn****","age":"20-29","gender":"M","email":"sh@naver.com","name":"\uc2e0\ubc94\ud638"}}
			**/
			
			//2. String형식인 apiResult를 json형태로 바꿈
			JSONParser parser = new JSONParser();
			Object obj = parser.parse(apiResult);
			JSONObject jsonObj = (JSONObject) obj;
			
			//3. 데이터 파싱 
			//Top레벨 단계 _response 파싱
			JSONObject response_obj = (JSONObject)jsonObj.get("response");
			//response의 nickname값 파싱
			String name = (String)response_obj.get("name");
	 
			System.out.println(name);
			
			//4.파싱 닉네임 세션으로 저장
			session.setAttribute("name",name); //세션 생성
			
			model.addAttribute("result", apiResult);
		     
			return "/member/Naverlogin";
		}
		
		//마이페이지 이동
		@RequestMapping(value = "mypage", method = RequestMethod.GET)
		public void mypageGET() {
					
			log.info("마이페이지 페이지 진입");
					
		}

	    
	    /* 로그아웃 */
		@RequestMapping(value = "logout", method = { RequestMethod.GET, RequestMethod.POST })
		public String logout(HttpSession session)throws IOException {
				System.out.println("logout 실행");
				session.invalidate();
		        
				return "redirect:/";
			}
	    
	   


}
