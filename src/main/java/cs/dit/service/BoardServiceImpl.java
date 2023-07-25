package cs.dit.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cs.dit.mapper.BoardMapper;
import cs.dit.model.BoardVO;
import cs.dit.model.Criteria;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	BoardMapper boardmapper;
	 
	//게시글 작성
	@Override
	public void boardWrite(BoardVO board) {
		boardmapper.boardWrite(board); 
	}

	//마이페이지 게시글 목록
	@Override
	public List<BoardVO> myGetList(BoardVO board) {
		return boardmapper.myGetList(board);
	}
	
	/* 게시글 목록 */
    @Override
    public List<BoardVO> getListPaging(Criteria cri) {
        
        return boardmapper.getListPaging(cri);
    }    
	
	//게시글 조회
	@Override
    public BoardVO getPage(int bno) throws Exception{
		return boardmapper.getPage(bno);
	}
	
	 /* 게시물 총 갯수 */
    @Override
    public int getTotal(Criteria cri) {
        
        return boardmapper.getTotal(cri);
    }    
	
	//게시글 수정
 	@Override
 	public void modifyBoard(BoardVO board){
 		
 		boardmapper.modifyBoard(board);
 	}
 	
 	//게시글 삭제
 	@Override
 	public void boardDelete(BoardVO board) throws Exception{
 		boardmapper.boardDelete(board);
 	}
		
	

}
