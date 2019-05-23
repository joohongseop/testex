package org.zerock.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@ToString
@Setter
@Getter
public class Criteria {

  private int pageNum;
  private int amount;
  
  private String type;
  private String keyword;

  //기본적인 페이지를 불러올 경우에는 페이지 넘버는 1, 개수는 10개로 불러온다.
  public Criteria() {
	  this(1, 10);
  }

  //현재의 페이지 넘버와 화면에 표시할 게시물의 개수를 받아온다.
  public Criteria(int pageNum, int amount) {
	  this.pageNum = pageNum;
	  this.amount = amount;
  }
  
  public String[] getTypeArr() {
	  return type == null? new String[] {}: type.split("");
  }
  
  //게시물의 삭제 후에 페이지 번호나 검색 조건을 유지하면서 이동하기 위해서 추가한 메소드
  //redirect에 필요한 파리미터들을 매번 추가해야 하는 번거로움을 해결하기 위해 추가함
  public String getListLink() {
	  UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
			  .queryParam("pageNum", this.pageNum)
			  .queryParam("amount", this.getAmount())
			  .queryParam("type", this.getType())
			  .queryParam("keyword", this.getKeyword());
		return builder.toUriString();
	}
}
