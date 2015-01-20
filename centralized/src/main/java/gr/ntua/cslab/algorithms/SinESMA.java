/**
 * ESMA algorithm that uses a reproducible form of 
 */
package gr.ntua.cslab.algorithms;

/**
 *
 * @author Giannis Giannakopoulos
 */
public class SinESMA extends AbstractSMA {

    public SinESMA() {
        super();
        this.randomPickSteps = Integer.MAX_VALUE;
    }

    
    @Override
    public boolean terminationCondition() {
        return (this.men.hasUnhappyPeople() || this.women.hasUnhappyPeople());
    }

    @Override
    protected boolean menPropose() {
        boolean menProposeFlag = Math.sin(this.stepCounter*this.stepCounter*this.stepCounter)>0;
        return menProposeFlag;
    }
    
    public static void main(String[] args) {
        AbstractSMA.runAlgorithm(SinESMA.class, args);
    }
}
