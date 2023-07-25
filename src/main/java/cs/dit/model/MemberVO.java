package cs.dit.model;

public class MemberVO {
	
		//회원 id
		private String memberId;
		
		//회원 비밀번호
		private String memberPw;
		
		//회원 이름
		private String memberName;
		
		//회원 전화번호
		private String memberTel;

		//회원 이메일
		private String memberEmail;
		
		//회원 유입경로
		private String memberRoute;
		
		//필수 약관 동의
		private String memberAgreeES;
		
		//SNS 수신 동의
		private String memberAgreeSNS;
		
		//기타 약관 동의
		private String memberAgreeOther;
		
		public String getMemberId() {
			return memberId;
		}

		public void setMemberId(String memberId) {
			this.memberId = memberId;
		}

		public String getMemberPw() {
			return memberPw;
		}

		public void setMemberPw(String memberPw) {
			this.memberPw = memberPw;
		}

		public String getMemberName() {
			return memberName;
		}

		public void setMemberName(String memberName) {
			this.memberName = memberName;
		}

		public String getMemberTel() {
			return memberTel;
		}

		public void setMemberTel(String memberTel) {
			this.memberTel = memberTel;
		}
		
		public String getMemberEmail() {
			return memberEmail;
		}

		public void setMemberEmail(String memberEmail) {
			this.memberEmail = memberEmail;
		}
		

		public String getMemberRoute() {
			return memberRoute;
		}

		public void setMemberRoute(String memberRoute) {
			this.memberRoute = memberRoute;
		}
		
		public String getMemberAgreeES() {
			return memberAgreeES;
		}

		public void setMemberAgreeES(String memberAgreeES) {
			this.memberAgreeES = memberAgreeES;
		}

		public String getMemberAgreeSNS() {
			return memberAgreeSNS;
		}

		public void setMemberAgreeSNS(String memberAgreeSNS) {
			this.memberAgreeSNS = memberAgreeSNS;
		}

		public String getMemberAgreeOther() {
			return memberAgreeOther;
		}

		public void setMemberAgreeOther(String memberAgreeOther) {
			this.memberAgreeOther = memberAgreeOther;
		}

		@Override
		public String toString() {
			return "MemberVO [memberId=" + memberId + ", memberPw=" + memberPw + ", memberName=" + memberName
					+ ", memberTel=" + memberTel + ", memberEmail=" + memberEmail + ", memberRoute=" + memberRoute
					+ ", memberAgreeES=" + memberAgreeES + ", memberAgreeSNS=" + memberAgreeSNS + ", memberAgreeOther="
					+ memberAgreeOther + "]";
		}

		
		
		



}
