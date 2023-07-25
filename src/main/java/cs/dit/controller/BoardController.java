package cs.dit.controller;

import java.io.File;
import java.net.MalformedURLException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import cs.dit.model.BoardVO;
import cs.dit.model.Criteria;
import cs.dit.model.PageMakerDTO;
import cs.dit.service.BoardService;
import cs.dit.utils.UploadFileUtils;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping(value="/board")
@Log4j
public class BoardController {
	private static final Logger log = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private BoardService boardservice;
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	//메인페이지 이동
	@RequestMapping(value = "main", method = RequestMethod.GET)
	public String mainGET() {
								
		log.info("메인 페이지 진입");
				
		return "redirect:/";

	}
    
    /* 게시판 목록 페이지 접속(페이징 적용) */
    @GetMapping("/boardList")
    public void boardListGET(Model model, Criteria cri) {
        
        log.info("boardListGET");
        
        log.info("cri : " + cri);
        
        model.addAttribute("list", boardservice.getListPaging(cri));
        
        int total = boardservice.getTotal(cri);
        
        PageMakerDTO pageMake = new PageMakerDTO(cri, total);
        
        model.addAttribute("pageMaker", pageMake);
        
    }
    
	
	/* 마이페이지 게시글 페이지 이동 */
	@RequestMapping(value = "/myWrite", method = RequestMethod.POST)
	public void myWriteGET(Model model, BoardVO board, HttpServletRequest request) {
								
		log.info("마이페이지 게시글 페이지 진입");
	        
		model.addAttribute("list", boardservice.myGetList(board));
								
	}
	
	//게시글 조회
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public void getView(int bno, Model model,Criteria cri) throws Exception {

		model.addAttribute("view", boardservice.getPage(bno));
		
		model.addAttribute("cri", cri);

	}

	//게시글 등록 페이지 이동
    @GetMapping("boardWrite")
    public void boardEnrollGET() {
        
        log.info("게시판 등록 페이지 진입");
        
    }
    
    //게시글 쓰기
  	@RequestMapping(value="/boardWrite", method=RequestMethod.POST)
    public String boardWritePOST(BoardVO board, MultipartFile file) throws Exception{
  			
  		log.info("boardWrite 진입"); 
  		
  		
  		//폴더생성
  		String path = "C:\\upload\\"; //폴더 경로
  		File Folder = new File(path);

  		// 해당 디렉토리가 없다면 디렉토리를 생성.
  		if (!Folder.exists()) {
  			try{
  			    Folder.mkdir(); //폴더 생성합니다. ("새폴더"만 생성)
  			    System.out.println("폴더 생성완료.");
  		        } 
  		        catch(Exception e){
  			    e.getStackTrace(); }        
  	         }else {
  	        	 System.out.println("폴더가 이미 존재합니다..");
  	         }

  		
  		//파일 업로드
  		String imgUploadPath = uploadPath;
  		String fileName=null;
  		MultipartFile uploadFile = board.getUploadFile();
  		
  		if (!uploadFile.isEmpty()) {
  			String originalFileName = uploadFile.getOriginalFilename();
  			String ext = FilenameUtils.getExtension(originalFileName);	//확장자 구하기
  			UUID uuid = UUID.randomUUID();	//UUID 구하기
  			fileName=uuid+"."+ext;
  			uploadFile.transferTo(new File("C:\\upload\\" + fileName));
  		}
  			board.setFileName(fileName);
  			board.setOrigiFile( File.separator + "upload" + File.separator + fileName );

  		// 글쓰기 서비스 실행
  		boardservice.boardWrite(board);
  			
  		log.info("boardWrite Service 성공");
  			
  		return "redirect:/board/boardList";
  			
  	}
  	

  	//게시글 수정 페이지 이동
    @GetMapping("modifyBoard")
    public void modifyBoardGET(int bno, Model model) throws Exception {
    	
    	model.addAttribute("view", boardservice.getPage(bno));
        
        log.info("게시글 수정 페이지 진입");
        
    }
  	
 	//게시물 수정
 	@RequestMapping(value="/modifyBoard", method=RequestMethod.POST)
 	public String modifyBoardPOST(BoardVO board, RedirectAttributes rttr, MultipartFile file, HttpServletRequest req) throws Exception{
 				
 		log.info("modifyBoard 진입"); 

 		//파일 업로드
  		String imgUploadPath = uploadPath;
  		String fileName=null;
  		MultipartFile uploadFile = board.getUploadFile();

 		 // 새로운 파일이 등록되었는지 확인
 		 if(uploadFile.getOriginalFilename() != null && uploadFile.getOriginalFilename() != "") {
 			 
		    // 기존 파일을 삭제
		 	new File(uploadPath + req.getParameter("fileName")).delete();
		 	
		 	//새로운 파일 저장
		 	String originalFileName = uploadFile.getOriginalFilename();
  			String ext = FilenameUtils.getExtension(originalFileName);	//확장자 구하기
  			UUID uuid = UUID.randomUUID();	//UUID 구하기
  			fileName=uuid+"."+ext;
  			uploadFile.transferTo(new File("C:\\upload\\" + fileName));
  			
  			board.setFileName(fileName);
  			board.setOrigiFile( File.separator + "upload" + File.separator + fileName );

 		 } else {  // 새로운 파일이 등록되지 않았다면
 		  // 기존 이미지를 그대로 사용
 	      board.setFileName(req.getParameter("fileName"));
 	      board.setOrigiFile(req.getParameter("orifile"));

 		 }
 		
 		//수정 서비스 실행
 		boardservice.modifyBoard(board);
 		
 		rttr.addFlashAttribute("result", "modify success");
 				
 		log.info("게시글 수정 완료");
 				
 		return "redirect:/board/boardList";
 				
 	}
 	
 	// 게시글 삭제
 	@GetMapping("/boardDelete.do")
    public String deleteGET(BoardVO board, HttpServletRequest request) throws Exception{
          
    	//글 삭제 서비스 실행
        boardservice.boardDelete(board);
        
        log.info("글 삭제 완료");
        
        return "redirect:/board/boardList";    
        
        
    }
 			


}
