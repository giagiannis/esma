package gr.ntua.cslab.algorithms;

import gr.ntua.cslab.metrics.SexEqualnessCost;

public class ESMA extends AbstractSMA{

	private boolean estimatedLastTime=false, lastCall;
	
	public ESMA() {

	}

	@Override
	public boolean terminationCondition() {
		return this.men.hasUnhappyPeople() || this.women.hasUnhappyPeople();
	}

	@Override
	protected boolean menPropose() {
		if(!estimatedLastTime){
			SexEqualnessCost c = new SexEqualnessCost(men, women);
			lastCall=(this.men.hasUnhappyPeople() && (c.get()>0 || !this.women.hasUnhappyPeople()));
			estimatedLastTime=true;
		} else {
			estimatedLastTime=false;
			lastCall=!lastCall;
		}
		return lastCall;
	}
	
	public static void main(String[] args) {
		AbstractSMA.runAlgorithm(ESMA.class,args);
	}

}
