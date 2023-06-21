import utest.Runner;
import utest.ui.Report;

function main() {
	final runner = new Runner();
	runner.addCase(new TestLogger());
	//runner.addCase(new TestLevel());
	runner.addCase(new TestConsoleTarget());
	runner.addCase(new TestFileTarget());
	runner.addCase(new TestFormat());
	final report = Report.create(runner);
	runner.run();
}
