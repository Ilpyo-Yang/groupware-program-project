package com.spring.groupware.approval.model;

import java.util.List;
import java.util.Map;

import com.spring.groupware.member.model.MemberVO;

public interface InterApprovalDAO {

	// 문서번호 가져오기
	String getFileNo();

	// 모달창에 입력될 전체 사원명 가져오기
	List<MemberVO> getMemberList();

}