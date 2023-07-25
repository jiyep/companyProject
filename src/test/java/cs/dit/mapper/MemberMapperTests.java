package cs.dit.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cs.dit.model.MemberVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class MemberMapperTests {
	
	@Autowired
	private MemberMapper membermapper;
	
	/*
	//회원가입
	@Test
	public void memberJoin() throws Exception{
		MemberVO member = new MemberVO();
		
		member.setMemberId("test01");			//회원 id
		member.setMemberPw("test01");			//회원 비밀번호
		member.setMemberName("test01");		//회원 이름
		member.setMemberTel("test01");		//회원 전화번호
		member.setMemberRoute("test01");		//회원 유입경로
	
		membermapper.memberJoin(member);			//쿼리 메서드 실행
		
	}*/
	
	/*
	// 아이디 중복검사
		@Test
		public void memberIdChk() throws Exception{
			String id = "admin";	// 존재하지 않는 아이디
			String id2 = "test";	// 존재하는 아이디
			membermapper.idCheck(id);
			membermapper.idCheck(id2);
		}*/
	
	/* 로그인 쿼리 mapper 메서드 테스트 
    @Test
    public void memberLogin() throws Exception{
        
        MemberVO member = new MemberVO();   */ // MemberVO 변수 선언 및 초기화
        
        /* 올바른 아이디 비번 입력경우
        member.setMemberId("test");
        member.setMemberPw("test"); */
        
        /* 올바른 않은 아이디 비번 입력경우 
        //member.setMemberId("test1123");
        //member.setMemberPw("test1321321");
        
        membermapper.memberLogin(member);
        System.out.println("결과 값 : " + membermapper.memberLogin(member));
        
    }*/
	
	/* 회원 정보 수정 
	@Test
	public void authorModifyTest() {
		
		MemberVO member = new MemberVO();
				
		member.setMemberId("test22");

		member.setMemberPw("22test");
		member.setMemberTel("01055552222");
		
		membermapper.memberModify(member);

		
	}*/


}
