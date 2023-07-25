package cs.dit.service;

import java.util.List;
import java.util.Map;

import cs.dit.model.BoardVO;
import cs.dit.model.Criteria;


public interface BoardService {
	
	/* 게시글 등록 */
	public void boardWrite(BoardVO board);
    
    /* 게시판 목록(페이징 적용) */
    public List<BoardVO> getListPaging(Criteria cri);
    
    /* 마이페이지 게시판 목록*/
    public List<BoardVO> myGetList(BoardVO board);
    
    /* 게시판 조회 */
    public BoardVO getPage(int bno) throws Exception;

    /* 게시판 총 갯수 */
    public int getTotal(Criteria cri);
    
    /* 게시판 수정 */
    public void modifyBoard(BoardVO board);
    
    /* 게시글 삭제 */
  	public void boardDelete(BoardVO board) throws Exception;

}
