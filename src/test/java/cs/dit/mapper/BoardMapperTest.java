package cs.dit.mapper;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import java.lang.System.Logger;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import lombok.extern.log4j.Log4j;
import cs.dit.controller.BoardController;
import cs.dit.model.Criteria;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTest {
	
	@Autowired
	private BoardMapper boardmapper;
	
    /* 게시판 목록(페이징 적용)테스트 */
//   @Test
//   public void testGetListPaging() {
//       
//       Criteria cri = new Criteria();
//       
//       cri.setPageNum(2);
//                        
//       List list = boardmapper.getListPaging(cri);
//       
//       list.forEach(board -> log.info("" + board));
//   }

}
