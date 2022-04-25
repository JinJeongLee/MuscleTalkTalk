package kh.semi.mtt.board.model.dao;

import static kh.semi.mtt.common.jdbc.JdbcTemplate.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

import kh.semi.mtt.board.model.vo.BoardVo;

public class BoardDao {
	private Statement stmt = null;
	private ResultSet rs = null;
	private PreparedStatement pstmt = null;
	
	public int deleteBoard(Connection conn, BoardVo vo) {
		int result = 0;
		String sql = "delete from tb_board where board_no = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getBoardNo());
			
			result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}
	
	
	
	
	
	
	
	
	
	
	public int updateBoard(Connection conn, BoardVo vo) {
		int result = 0;
		String sql = "update tb_board set BOARD_TITLE=?, BOARD_CONTENT=? where BOARD_NO=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getBoardTitle());
			pstmt.setString(2, vo.getBoardContent());
			pstmt.setInt(3, vo.getBoardNo());
			result = pstmt.executeUpdate();
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
		finally {
			close(pstmt);
		}
		return result;
	}
	
	
	
	
	
	public int insertBoard(Connection conn, BoardVo vo) {
//		String m_nickname = "aaa";
		int memberNo = 13;
		int board_count = 0;
		int result = 0;
//		BOARD_NO          NOT NULL NUMBER         
//		MEMBER_NO         NOT NULL NUMBER         
//		BOARD_TITLE       NOT NULL VARCHAR2(200)  
//		BOARD_CONTENT     NOT NULL VARCHAR2(1000) 
//		BOARD_COUNT       NOT NULL NUMBER         
//		BOARD_DATE        NOT NULL DATE           
//		BOARD_CATEGORY_NO NOT NULL NUMBER(1)  
//		String sql = "insert into tb_board values((SELECT nvl(max(BOARD_NO),0)+1 from TB_board),(select member_no from tb_member where member_no = '" + memberNo + "'),"  
//				+ vo.getBoardTitle() + "','" 
//				+ vo.getBoardContent() + "','" 
//				+ board_count +"','" + "sysdate , default)";
		String sql = "insert into tb_board (board_no, MEMBER_NO, BOARD_TITLE, BOARD_CONTENT, BOARD_COUNT, BOARD_DATE, BOARD_CATEGORY_NO) "
				+ "values ((SELECT nvl(max(BOARD_NO),0)+1 from TB_board), "+memberNo+", '"+ vo.getBoardTitle() +"', '"+vo.getBoardContent()+"', "+board_count+", default, default)";
		try {
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			close(stmt);
		}
		return result; 
	}
		
	public BoardVo readBoard(Connection conn, int boardNo) {
		BoardVo vo = null;
		String sql = "select b.BOARD_NO, m.MEMBER_nickname, b.BOARD_TITLE, b.BOARD_CONTENT, b.BOARD_COUNT, b.BOARD_DATE "
				   +" from tb_board b , tb_member m "
				   +" WHERE b.MEMBER_NO = m.MEMBER_NO AND BOARD_NO=? ";
		
		String sql2 = "update tb_board set board_count = board_count+1 where board_no=?";
		int result = 0;
				
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
			rs = pstmt.executeQuery();
			vo = new BoardVo();
			if(rs.next()) {
				vo.setBoardNo(rs.getInt("BOARD_NO"));
				vo.setBoardTitle(rs.getString("BOARD_TITLE"));
				vo.setMemberNickname(rs.getString("MEMBER_NICKNAME"));
				vo.setBoardContent(rs.getString("BOARD_CONTENT"));
				vo.setBoardCount(rs.getInt("BOARD_COUNT")+1);
				vo.setBoardDate(rs.getDate("BOARD_DATE"));
				
										//

				close(pstmt);
				
				pstmt = conn.prepareStatement(sql2);
				pstmt.setInt(1, boardNo);
				result = pstmt.executeUpdate();
				if(result == 1) {
					System.out.println("BoardDao에서 조회수 1증가 됨");
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return vo;
		
	}
	
	
	public ArrayList<BoardVo> readAllBoard(Connection conn, int startRnum, int endRnum, int filterint){ //매개인자로 필터 추가해서 정렬기능추가
		ArrayList<BoardVo> volist = null;
//		String sql = "select * from(select rownum r, t1.* from "
//		        + " (select b1.*,(select count(*) from tb_comment r1 where r1.board_no = b1.board_no) r_cnt " 
//		        + " from tb_board b1 order by board_no desc) t1)"
//		        + " where r between ? and ?";
		String sql = "select R, board_no, member_nickname, board_title, board_content, board_count, board_date, board_category_no, r_cnt from "
				+ " (select rownum r, t1.* from (select b1.*,(select count(*) from "
				+ " tb_comment r1 where r1.board_no = b1.board_no) r_cnt "
				+ " from tb_board b1 order by board_no desc) t1)tba join tb_member tbm on tba.member_no = tbm.member_no "
				+ " where r between ? and ?"
				+ " order by board_date desc";
		if(filterint == 1) {
			sql = "select R, board_no, member_nickname, board_title, board_content, board_count, board_date, board_category_no, r_cnt from "
				+ " (select rownum r, t1.* from (select b1.*,(select count(*) from "
				+ " tb_comment r1 where r1.board_no = b1.board_no) r_cnt "
				+ " from tb_board b1 order by board_no desc) t1)tba join tb_member tbm on tba.member_no = tbm.member_no "
				+ " where r between ? and ?"
				+ " order by board_date desc";
			
		}else if(filterint == 2) {
			sql = "select R, board_no, member_nickname, board_title, board_content, board_count, board_date, board_category_no, r_cnt from "
					+ " (select rownum r, t1.* from (select b1.*,(select count(*) from "
					+ " tb_comment r1 where r1.board_no = b1.board_no) r_cnt "
					+ " from tb_board b1 order by board_no desc) t1)tba join tb_member tbm on tba.member_no = tbm.member_no "
					+ " where r between ? and ?"
					+ " order by board_count desc";
			
		}else if(filterint == 3) {
			sql = "select R, board_no, member_nickname, board_title, board_content, board_count, board_date, board_category_no, r_cnt from "
					+ " (select rownum r, t1.* from (select b1.*,(select count(*) from "
					+ " tb_comment r1 where r1.board_no = b1.board_no) r_cnt "
					+ " from tb_board b1 order by board_no desc) t1)tba join tb_member tbm on tba.member_no = tbm.member_no "
					+ " where r between ? and ?"
					+ " order by r_cnt desc";
		}
		
		
		System.out.println(sql);
		
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRnum);		
			pstmt.setInt(2, endRnum);
			rs = pstmt.executeQuery();
			if(rs != null) {
				volist = new ArrayList<BoardVo>();
				while (rs.next()) {
					BoardVo vo = new BoardVo();
					vo.setBoardNo(rs.getInt("BOARD_NO"));
					vo.setBoardDate(rs.getDate("BOARD_DATE"));
					vo.setBoardTitle(rs.getString("BOARD_TITLE"));
					vo.setBoardContent(rs.getString("BOARD_CONTENT"));
					vo.setBoardCount(rs.getInt("BOARD_COUNT"));
					vo.setMemberNickname(rs.getString("MEMBER_NICKNAME"));
					vo.setrCnt(rs.getInt("R_CNT"));
//					System.out.println("댓글수"+rs.getInt("R_CNT"));
					volist.add(vo);
					
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}  finally {
			close(rs);
			close(pstmt);
		}
		return volist;
	}
	public int boardViewCount(Connection conn ,BoardVo vo) {
		String sql = "update tb_board set board_count = board_count+1 where board_no=?";
		
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getBoardNo());
			result = pstmt.executeUpdate();
			
			System.out.println("조회수 1증가");
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally {
			close(conn);
			close(pstmt);
		}
		return result;
	}
	
	
	public int countBoard(Connection conn) {
		int result = 0;
		String sql = "select count(*) as cnt from tb_board";

		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt("cnt");

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		finally {
			close(rs);
			close(pstmt);
		}

		return result;

	}
	
	
	
}
