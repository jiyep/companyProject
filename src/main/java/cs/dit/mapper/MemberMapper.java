package cs.dit.mapper;

import cs.dit.model.MemberVO;

public interface MemberMapper {
	
	//일반 회원가입
	public void memberJoin(MemberVO member);
	
	// 아이디 중복 검사
	public int idCheck(String memberId);
	
	// 이메일 중복 검사
	public int emailCheck(String memberEmail);
	
	// 로그인 
    public MemberVO memberLogin(MemberVO member);
    
    //소셜 로그인 
    public MemberVO memberSnsLogin(MemberVO member);
    
    //회원정보 수정
    public void memberModify(MemberVO member);
    
    //회원정보 읽어오기
    public MemberVO readMember(String id);
    
    // 비밀번호 변경
    public int updatePw(MemberVO member);
    
    //회원탈퇴
    public void memberDelete(MemberVO member);

}
