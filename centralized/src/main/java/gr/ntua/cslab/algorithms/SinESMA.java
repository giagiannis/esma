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
        boolean menproposeflag = Math.sin(Math.pow(this.stepCounter, 3.0))>0;
        return (Math.sin(Math.pow(this.stepCounter, 3.0))>0);
    }
    
    public static void main(String[] args) {
        AbstractSMA.runAlgorithm(SinESMA.class, args);
    }
}
