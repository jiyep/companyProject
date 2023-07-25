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
		
		//회원 유입경로
		private String memberRoute;
		
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
		

		public String getMemberRoute() {
			return memberRoute;
		}

		public void setMemberRoute(String memberRoute) {
			this.memberRoute = memberRoute;
		}

		@Override
		public String toString() {
			return "MemberVO [memberId=" + memberId + ", memberPw=" + memberPw + ", memberName=" + memberName
					+ ", memberTel=" + memberTel + ", memberRoute=" + memberRoute + "]";
		}
		
		



}
