import React from 'react';
import { StyleSheet, Text, View, Button } from 'react-native';
var Buglife = require('react-native-buglife');

export default class App extends React.Component {
  onPressFeedback =()=> {
    Buglife.presentReporter();
  }

  render() {
    return (
      <View style={styles.container}>
        <Text>
          Run this app on a device, and either {"\n\n"}
          1. Take a screenshot to send feedback! {"\n"}
          2. Tap the "Send Feedback" button below. {"\n"}
        </Text>
        <Button onPress={this.onPressFeedback} title="Send feedback" color="#841584" />
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
});
