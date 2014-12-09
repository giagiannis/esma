package gr.ntua.cslab.algorithms;

import gr.ntua.cslab.containers.Person;
import gr.ntua.cslab.metrics.SexEqualnessCost;
import java.util.Iterator;

public final class ESMATerm extends AbstractSMA {

    private boolean estimatedLastTime = false, lastCall;

    private int alternatingThreshold;

    public ESMATerm() {
        this.setAlternatingThreshold(5000);
        this.randomPickSteps = Integer.MAX_VALUE;

    }

    /**
     * Returns the maximum number of steps for which the proposers will be alternating.
     * @return 
     */
    public int getAlternatingThreshold() {
        return alternatingThreshold;
    }

    /**
     * Sets the maximum number of steps for which the proposers will be alternating.
     * @param alternatingThreshold 
     */
    public void setAlternatingThreshold(int alternatingThreshold) {
        this.alternatingThreshold = alternatingThreshold;
    }

    @Override
    public boolean terminationCondition() {
        if(this.stepCounter > this.alternatingThreshold)
            return this.men.hasUnhappyPeople() && this.women.hasUnhappyPeople();
        else
            return this.men.hasUnhappyPeople() || this.women.hasUnhappyPeople();
    }

    @Override
    protected boolean menPropose() {
        if(this.stepCounter == this.alternatingThreshold) {
            Iterator<Person> menIt = this.men.getIterator();
            while(menIt.hasNext()){
                Person p = menIt.next();
                for(int i=1;i<=this.men.size();i++)
                    p.getPreferences().addNext(i);
            }
        }
        if(this.stepCounter >= this.alternatingThreshold) {
            
            return true;
        }
        if (!estimatedLastTime) {
            SexEqualnessCost c = new SexEqualnessCost(men, women);
            lastCall = (this.men.hasUnhappyPeople() && (c.get() > 0 || !this.women.hasUnhappyPeople()));
            estimatedLastTime = true;
        } else {
            estimatedLastTime = false;
            lastCall = !lastCall;
        }
        return lastCall;
    }

    public static void main(String[] args) {
        AbstractSMA.runAlgorithm(ESMATerm.class, args);
    }

}
