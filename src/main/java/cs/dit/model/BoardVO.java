package cs.dit.model;

import java.sql.Blob;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class BoardVO {
	
	 /* 게시판 번호 */
    private int bno;
    
    /* 게시판 제목 */
    private String title;
    
    /* 게시판 내용 */
    private String content;
    
    /* 파일 이름 */
    private String fileName;
    
    /* 파일 경로 */
    private String origiFile;
    
    /* 파일 */
    private MultipartFile uploadFile;

    /* 게시판 작가 */
    private String writer;
    
    /* 등록 날짜 */
    private Date regdate;
    
    /* 게시판 등록 아이디 */
    private String memberId;

	public int getBno() {
		return bno;
	}

	public void setBno(int bno) {
		this.bno = bno;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	public String getOrigiFile() {
		return origiFile;
	}

	public void setOrigiFile(String origiFile) {
		this.origiFile = origiFile;
	}

	public MultipartFile getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	@Override
	public String toString() {
		return "BoardVO [bno=" + bno + ", title=" + title + ", content=" + content + ", fileName=" + fileName
				+ ", origiFile=" + origiFile + ", writer=" + writer + ", regdate=" + regdate + ", memberId=" + memberId + "]";
	}


	

	


}
