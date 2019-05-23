package org.zerock.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {

  private int startPage;
  private int endPage;
  private boolean prev, next;

  private int total;
  private Criteria cri;

  //Criteria의 생성자와 총 개수를 받아온다.
  public PageDTO(Criteria cri, int total) {

    this.cri = cri;
    this.total = total;
    
    //(표시할) 마지막 페이지는 현재 페이지의 값을 받아서 계산한다.
    //10페이지씩 나누어서 표시하기 때문에 마지막 페이지는 10의 배수가 된다.
    //예를 들어 5페이지가 들어오면 Math.ceil(5/10)*10 => Math.ceil(0.5)*10 => 1*10 = 10이 된다.
    this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;

    //시작페이지는 마지막 페이지에서 9를 뺀 값이 된다.
    this.startPage = this.endPage - 9;

    //실제 마지막 페이지는 총량을 표시할 개수로 나눈 값을 올림해서 결정된다. 표시할 개수는 10개로 정해져 있다.
    //예를 들어 109개의 게시물이 있다면 109/10 => 10.9 => 11페이지가 실제 마지막 페이지가 된다.
    int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));

    //실제 마지막 페이지가 표기할 마지막 페이지보다 작을 경우 마지막 페이지를 실제 마지막 페이지로 한다.
    //이 경우에는 startPage가 항상 1이고 endPage가 realEnd와 같게 되므로 prev와 next는 항상 거짓이 된다.
    if (realEnd <= this.endPage) {
      this.endPage = realEnd;
    }

    //prev는 startPage가 1보다 클 경우에만 참이된다.
    this.prev = this.startPage > 1;

    //next는 endPage가 realEnd보다 작을 경우, 즉, 실제 마지막 페이지가 표기되는 마지막 페이지보다 큰 경우에만 참이 된다.
    this.next = this.endPage < realEnd;
  }
  
}

