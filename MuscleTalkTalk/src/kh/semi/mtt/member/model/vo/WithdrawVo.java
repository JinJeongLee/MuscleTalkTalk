package kh.semi.mtt.member.model.vo;

public class WithdrawVo {
	private int result;
	private int num;
	@Override
	public String toString() {
		return "WithdrawVo [result=" + result + ", num=" + num + "]";
	}
	public int getResult() {
		return result;
	}
	public void setResult(int result) {
		this.result = result;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	
}
