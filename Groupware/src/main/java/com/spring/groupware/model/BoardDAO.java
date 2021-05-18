package com.spring.groupware.model;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
// import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

//=== #32. DAO 선언 ===
@Component
@Repository
public class BoardDAO implements InterBoardDAO {
    // === #33. 의존객체 주입하기(DI: Dependency Injection) ===
    // >>> 의존 객체 자동 주입(Automatic Dependency Injection)은
    //     스프링 컨테이너가 자동적으로 의존 대상 객체를 찾아서 해당 객체에 필요한 의존객체를 주입하는 것을 말한다. 
    //     단, 의존객체는 스프링 컨테이너속에 bean 으로 등록되어 있어야 한다. 

    //     의존 객체 자동 주입(Automatic Dependency Injection)방법 3가지 
    //     1. @Autowired ==> Spring Framework에서 지원하는 어노테이션이다. 
    //                       스프링 컨테이너에 담겨진 의존객체를 주입할때 타입을 찾아서 연결(의존객체주입)한다.
   
    //     2. @Resource  ==> Java 에서 지원하는 어노테이션이다.
    //                       스프링 컨테이너에 담겨진 의존객체를 주입할때 필드명(이름)을 찾아서 연결(의존객체주입)한다.
   
    //     3. @Inject    ==> Java 에서 지원하는 어노테이션이다.
    //                       스프링 컨테이너에 담겨진 의존객체를 주입할때 타입을 찾아서 연결(의존객체주입)한다.   

	/*
	@Autowired
	private SqlSessionTemplate abc;
	// Type 에 따라 Spring 컨테이너가 알아서 root-context.xml 에 생성된 org.mybatis.spring.SqlSessionTemplate 의 bean 을  abc 에 주입시켜준다. 
    // 그러므로 abc 는 null 이 아니다.
	*/
	
	
	@Resource
	private SqlSessionTemplate sqlsession; // 로컬 DB에 연결
	// 로컬DB에 연결
    // Type 에 따라 Spring 컨테이너가 알아서 root-context.xml 에 생성된 org.mybatis.spring.SqlSessionTemplate 의 bean 을  abc 에 주입시켜준다. 
    // 그러므로 sqlsession 는 null 이 아니다.
	
	
	@Resource
	private SqlSessionTemplate sqlsession2; // 원격 DB에 연결
	// 로컬DB에 연결
    // Type 에 따라 Spring 컨테이너가 알아서 root-context.xml 에 생성된 org.mybatis.spring.SqlSessionTemplate 의 bean 을  abc 에 주입시켜준다. 
    // 그러므로 sqlsession2 는 null 이 아니다.
	
	
	@Resource
	private SqlSessionTemplate sqlsession3; // 로컬 DB에 hr로 연결
	// 로컬DB에 연결
    // Type 에 따라 Spring 컨테이너가 알아서 root-context.xml 에 생성된 org.mybatis.spring.SqlSessionTemplate 의 bean 을  abc 에 주입시켜준다. 
    // 그러므로 sqlsession3 는 null 이 아니다.
	
	
	// spring_test 테이블에 insert 하기
	@Override
	public int test_insert() {
		int n = sqlsession.insert("board.test_insert");	
		// namespace 가 board 인 xml 에서 id 가 test_insert 인 것을 쓰겠다.
		return n;
	}

	
	// spring_test 테이블에 select 하기
	@Override
	public List<TestVO> test_select() {
		List<TestVO> testvoList = sqlsession.selectList("board.test_select");	
		return testvoList;
	}

	
	// view단의 form 태그에서 입력받은 값을 spring_test 테이블에  insert 하기
	@Override
	public int test_insert(Map<String, String> paraMap) {
		int n = sqlsession.insert("board.test_insert_map",paraMap);	
		return n;

	}

	
	// view단의 form 태그에서 입력받은 값을 spring_test 테이블에  insert 하기	(메소드 오버로딩)
	@Override
	public int test_insert(TestVO vo) {
		int n = sqlsession.insert("board.test_insert_vo",vo);	
		return n;
	}
	
	
	// hr.employees 테이블의 정보를 select 해오기
	@Override
	public List<Map<String, String>> test_employees() {
		List<Map<String, String>> empList = sqlsession3.selectList("hr.test_employees");	
		return empList;
	}


	// === #38. 메인 페이지용 이미지 파일을 가져오기 === // 
	@Override
	public List<String> getImgfilenameList() {
		List<String> imgfilenameList = sqlsession.selectList("board.getImgfilenameList");
		return imgfilenameList;
	}

	// === #46. 로그인 처리하기 === // 
	@Override
	public MemberVO getLoginMember(Map<String, String> paraMap) {
		MemberVO loginuser = sqlsession.selectOne("board.getLoginMember", paraMap);
		return loginuser;
	}
	@Override
	public int updateIdle(String userid) {
		int n = sqlsession.update("board.updateIdle", userid);
		return n;
	}
	
	
}