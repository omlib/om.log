import utest.Runner;
import utest.ui.Report;

function main() {
	var runner = new Runner();
	runner.addCase(new TestLogger());
	runner.addCase(new TestLevel());
	runner.addCase(new TestConsoleTransport());
	runner.addCase(new TestFileTransport());
	var report = Report.create(runner);
	runner.run();
}
